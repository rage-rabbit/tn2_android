
public class FFT
{
  //properties goes here
  double[] real;
  double[] imag;
  
  //constructor goes here
  FFT(double[] real, double[] imag)
  {
    this.real = real;
    this.imag = imag;
  }
  
  //the actual fft function
  double[] fft(double[] real, double[] imag) {
    int n = real.length;

    // Ensure input is valid
    if (n != imag.length || (n & (n - 1)) != 0) {
      throw new IllegalArgumentException("Input arrays must have equal length and be a power of 2.");
    }

    // Bit-reversal permutation
    int j1 = 0;
    for (int i = 1; i < n; i++) {
      int bit = n >> 1;
      while ((j1 & bit) != 0) {
        j1 ^= bit;
        bit >>= 1;
      }
      j1 ^= bit;

      if (i < j1) {
        // Swap real
        double temp = real[i];
        real[i] = real[j1];
        real[j1] = temp;

        // Swap imag
        temp = imag[i];
        imag[i] = imag[j1];
        imag[j1] = temp;
      }
    }

    // Cooley-Tukey FFT
    for (int len = 2; len <= n; len <<= 1) {
      double angle = -2 * Math.PI / len;
      double wLenReal = Math.cos(angle);
      double wLenImag = Math.sin(angle);

      for (int i = 0; i < n; i += len) {
        double wr = 1.0;
        double wi = 0.0;

        for (int j = 0; j < len / 2; j++) {
          int evenIndex = i + j;
          int oddIndex = i + j + len / 2;

          double uReal = real[evenIndex];
          double uImag = imag[evenIndex];
          double tReal = wr * real[oddIndex] - wi * imag[oddIndex];
          double tImag = wr * imag[oddIndex] + wi * real[oddIndex];

          real[evenIndex] = uReal + tReal;
          imag[evenIndex] = uImag + tImag;
          real[oddIndex] = uReal - tReal;
          imag[oddIndex] = uImag - tImag;

          double tmpWr = wr;
          wr = wr * wLenReal - wi * wLenImag;
          wi = tmpWr * wLenImag + wi * wLenReal;
        }
      }
    }
    
    // Return magnitude of the FFT bins
    double[] bins = new double[n / 2];  // Only need the first half of the FFT bins
    
    for (int i = 0; i < n / 2; i++) {
      bins[i] = Math.sqrt(real[i] * real[i] + imag[i] * imag[i]);
    }
    
    return bins;
  }
}

public class HPS {
  //properties goes here
  double[] bins;
  
  //constructor goes here
  HPS(double[] bins)
  {
    this.bins = bins;
  }
  
  // Method to calculate Harmonic Product Spectrum
  double[] hps(double[] bins) {
    int n = bins.length;
    double[] hps = new double[n];

    // Start with the original bins as the first harmonic
    System.arraycopy(bins, 0, hps, 0, n);

    // Multiply with downsampled versions for each harmonic
    for (int harmonic = 2; harmonic <= 5; harmonic++) {  // 2nd, 3rd, ..., 5th harmonics (you can adjust the number of harmonics)
      for (int i = 0; i < n / harmonic; i++) {
        hps[i] *= bins[i * harmonic];
      }
    }

    // Return the harmonic product spectrum
    return hps;
  }

  // Method to find the peak index in the HPS result
  int findPeakIndex(double[] hps) {
    int peakIndex = 0;
    double maxMag = -1;
    
    // Find the peak of the harmonic product spectrum
    for (int i = 1; i < hps.length - 1; i++) {
      if (hps[i] > maxMag) {
        maxMag = hps[i];
        peakIndex = i;
      }
    }
    return peakIndex;
  }
}

class audioStreamer implements Runnable {
  //make the audio stream generator its own thread so it doesn't block the app itself...
  
  //initialize the array
  short[] audioSample;
  
  public void run() {
    //only write the buffer if the sound is playing...
    if(refTone.getPlayState() == AudioTrack.PLAYSTATE_PLAYING)
    {
      //first constrain the frequency so it wouldn't go to infinity and break the app
      float freqConstrained = constrain(freq[1], 0, Float.MAX_VALUE);
      
      //generate sample...
      audioSample = generateSound((double)freqConstrained);
      
      //...and then write to buffer
      refTone.write(audioSample, 0, audioSample.length);
    }
  }
}

class audioRecorder implements Runnable {
  //make the tuner itself its own thread so it also doesn't block the app itself
  
  //initialize the array
  int bufferSizeInBytes = AudioRecord.getMinBufferSize(sampleRate, channelConfigIn, audioFormat);
  int bufferSizeInShorts = bufferSizeInBytes / 2;
  int fftSize = nextPowerOfTwo(bufferSizeInShorts);

  short[] audioSample = new short[fftSize];
  double[] doubleSample = new double[audioSample.length], 
    real = new double[audioSample.length], 
    imag = new double[audioSample.length], 
    bins = new double[audioSample.length];
  FFT fft = new FFT(real, imag);
  HPS hps = new HPS(bins);
  
  public void run() {
    
    //only write the buffer if device is recording...
    if(tuner.getRecordingState() == AudioRecord.RECORDSTATE_RECORDING)
    {
      int read = tuner.read(audioSample, 0, audioSample.length);
      float sum = 0;
      double[] real_windowed;
      double[] bins_hps;

      //detect if listening or not
      isListening = ((float)getRMS(audioSample) > amplitudeThreshold) ? true : false;
    
      for(int i = 0; i < audioSample.length; i++)
      {
        //make the real array the audioSample but in double instead of short
        real[i] = (double)audioSample[i];
        //fft uses complex mathematics (i.e. uses both real and imaginary numbers). however since we use an audio sample which only contain real numbers, imaginary part can just be zeroes
        imag[i] = 0.0;
      }
      
      if (isListening == true && read > 0) {
        
        //apply windowing function here
        real_windowed = windowFunc(real);
      
        //perform fft to the audio...
        bins = fft.fft(real_windowed, imag);
        
        //perform hps to the fft bins...
        bins_hps = hps.hps(bins);
        
        //freq[0] = (float)findPitch(bins, audioSample.length)/*(fft.real, fft.imag)*/;
        
        freqTemp[listenerIndex] = (float)findPitch(bins_hps, audioSample.length);
        if(listenerIndex >= freqTempBufferSize-1){listenerIndex = 1;if(isListeningPrev==false){isListeningPrev=true;}}else{listenerIndex += 1;}
        
        //...then pass it to freq[0]
        for (int i=0; i<freqTemp.length; i++) {
          sum += freqTemp[i];
        }
        
        freq[0] = sum/(freqTemp.length-((isListeningPrev == false) ? freqTempBufferSize-listenerIndex : 0));
        sum = 0;
      }
      
      if (isListening == false) {
        listenerIndex = 0;
        isListeningPrev = false;
        
        for (int i=0;i<freqTemp.length;i++) {
          freqTemp[i] = 0;
        }
      }
      
    }
  }
}
