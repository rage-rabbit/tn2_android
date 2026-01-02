//TODO: make this redundant, use JSON instead

//dear god the code below is just a massive spaghetti
String guitar_6_std[] = {"Standard", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_6_stdhstd[] = {"Half-step Down", "D#2/Eb2", "G#2/Ab2", "C#3/Db3", "F#3/Gb3", "A#3/Bb3", "D#4/Eb4"};
String guitar_6_stdfstd[] = {"Full-step Down", "D2", "G2", "C3", "F3", "A3", "D4"};
String guitar_6_dropd[] = {"Drop D", "D2", "A2", "D3", "G3", "B3", "E4"};
String guitar_6_doubledropd[] = {"Double Drop D", "D2", "A2", "D3", "G3", "B3", "D4"};
String guitar_6_dadgad[] = {"DADGAD", "D2", "A2", "D3", "G3", "A3", "D4"};
String guitar_6_dropc[] = {"Drop C", "C2", "G2", "C3", "F3", "A3", "D4"};
String guitar_6_openc[] = {"Open C", "C2", "G2", "C3", "F3", "A3", "D4"};
String guitar_6_opend[] = {"Open D", "D2", "A2", "D3", "F#3/Gb3", "A3", "D4"};
String guitar_6_opene[] = {"Open E", "E2", "B2", "E3", "G#3/Ab3", "B3", "E4"};
String guitar_6_openg[] = {"Open G", "D2", "G2", "D3", "G3", "B3", "D4"};

String guitar_7_std[] = {"Standard", "B1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_dropa[] = {"Drop A", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_dropg[] = {"Drop G", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_dropc[] = {"Drop C", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_stdc[] = {"Standard C", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_opena[] = {"Open A", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_7_opend[] = {"Open D", "A1", "E2", "A2", "D3", "G3", "B3", "E4"};

String guitar_8_std[] = {"Standard", "F#1/Gb1", "B1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_8_stdhstd[] = {"Half-step Down", "F1", "A#1/Bb1", "D#2/Eb2", "G#2/Ab2", "C#3/Db3", "F#3/Gb3", "A#3/Bb3", "D#4/Eb4"};
String guitar_8_drope[] = {"Drop E", "E1", "B1", "E2", "A2", "D3", "G3", "B3", "E4"};
String guitar_8_dropeb[] = {"Drop D#/Eb", "D#1/Eb1", "A#1/Bb1", "D#2/Eb2", "G#2/Ab2", "C#3/Db3", "F#3/Gb3", "A#3/Bb3", "D#4/Eb4"};

String bass_4_std[] = {"Standard", "E1", "A1", "D2", "G2"};
String bass_4_stdhstd[] = {"Half-step Down", "D#1/Eb1", "G#1/Ab1", "C#2/Db2", "F#2/Gb2"};
String bass_4_stdfstd[] = {"Full-step Down", "D1", "G1", "C2", "F2"};
String bass_4_dropd[] = {"Drop D", "D1", "A1", "D2", "G2"};
String bass_4_bead[] = {"BEAD", "B0", "E1", "A1", "D2"};
String bass_4_cgda[] = {"Classical Bass", "C1", "G1", "D2", "A2"};
String bass_4_fsbea[] = {"Extended Range", "F#0/Gb0", "B0", "E1", "A1"};
String bass_4_adgc[] = {"Octave Down", "A0", "D1", "G1", "C2"};
String bass_4_opend[] = {"Open D", "D1", "A1", "D2", "F#2/Gb2"};

String bass_5_std[] = {"Standard", "B0", "E1", "A1", "D2", "G2"};
String bass_5_stdhstd[] = {"Half-step Down", "D#1/Eb1", "G#1/Ab1", "C#2/Db2", "F#2/Gb2", "A#2/Bb2"};
String bass_5_stdfstd[] = {"Full-step Down", "D0", "G0", "C1", "F1", "A#1/Bb1"};
String bass_5_dropa[] = {"Drop A", "A0", "D1", "G1", "C2", "F2"};
String bass_5_dropd[] = {"Drop D", "D0", "E1", "A1", "D2", "G2"};
String bass_5_cgdae[] = {"Classical Bass", "C1", "G1", "D2", "A2"};
String bass_5_fsbea[] = {"Extended Range", "F#0/Gb0", "B0", "E1", "A1", "E2"};
String bass_5_dadgd[] = {"DADGD", "D0", "A0", "D1", "G1", "D2"};

//don't forget to invert, because logic is backwards on refchart
String drum_bass_snare_std[] = {"Standard", "G3", "D2"};
String drum_bass_snare_low[] = {"Low", "E3", "A1"};
String drum_bass_snare_high[] = {"High", "A#3/Bb3", "G2"};

//bass, snare, tom1, tom2, tom3, ftom1, ftom2
//https://tune-bot.com/tunebottuningguide.pdf
//don't forget to invert, because logic is backwards on refchart
String drum_toms_10_14[] = {"Perfect Fifth", "", "", "F2", "", "C3", ""};
String drum_toms_12_16[] = {"Perfect Fifth", "D2", "", "", "A2", "", ""};
String drum_toms_10_12_14[] = {"Major Chord", "", "F2", "", "A2", "C3", ""};
String drum_toms_10_12_16[] = {"Perfect Fourths", "D2", "C3", "", "G2", "C3", ""};
String drum_toms_12_13_16[] = {"Major Thirds", "C#2/Db2", "", "F2", "A2", "", ""};
String drum_toms_12_14_16[] = {"Perfect Fourths", "C2", "F2", "", "A2", "", ""};
String drum_toms_10_12_14_16[] = {"Call to Post", "D2", "G2", "", "2B", "D3", ""};
String drum_toms_10_12_14_16_alt[] = {"Perfect Fourths", "C#2/Db2", "F#2/Gb2", "", "B2", "E3", ""};
String drum_toms_8_10_12_14_16[] = {"Major Thirds", "C2", "E2", "", "G#2/Ab2", "C3", "E3"};
String drum_toms_8_10_12_13_14_16[] = {"Major Thirds", "C2", "E2", "G#2/Ab2", "C3", "E3", "G#3/Ab3"};

String tuningGuitar_6[][] = {{"Guitar (6-String)"}, guitar_6_std, guitar_6_stdhstd, guitar_6_stdfstd, guitar_6_dropd, guitar_6_doubledropd, guitar_6_dadgad, guitar_6_dropc, guitar_6_openc, guitar_6_opend, guitar_6_opene, guitar_6_openg};
String tuningGuitar_7[][] = {{"Guitar (7-String)"}, guitar_7_std, guitar_7_dropa, guitar_7_dropg, guitar_7_dropc, guitar_7_stdc, guitar_7_opena, guitar_7_opend};
String tuningGuitar_8[][] = {{"Guitar (8-String)"}, guitar_8_std, guitar_8_stdhstd, guitar_8_drope, guitar_8_dropeb};
String tuningBassGuitar_4[][] = {{"Bass Guitar (4-String)"}, bass_4_std, bass_4_stdhstd, bass_4_stdfstd, bass_4_dropd, bass_4_bead, bass_4_cgda, bass_4_fsbea, bass_4_adgc, bass_4_opend};
String tuningBassGuitar_5[][] = {{"Bass Guitar (5-String)"}, bass_5_std, bass_5_stdhstd, bass_5_stdfstd, bass_5_dropa, bass_5_dropd, bass_5_cgdae, bass_5_fsbea, bass_5_dadgd};
String tuningBassGuitar_6[][] = {{"Bass Guitar (6-String)"}}; //UNUSED
String tuningDrum[][] = {{"Drumkit (Bass + Snare)"}, drum_bass_snare_std, drum_bass_snare_low, drum_bass_snare_high};
String tuningDrumToms[][] = {{"Drumkit (Toms)"}, drum_toms_10_14, drum_toms_12_16, drum_toms_10_12_14, drum_toms_10_12_16, drum_toms_12_13_16, drum_toms_12_14_16, drum_toms_10_12_14_16, drum_toms_10_12_14_16_alt, drum_toms_8_10_12_14_16, drum_toms_8_10_12_13_14_16};

String instruments[][][] = {tuningGuitar_6, tuningGuitar_7, tuningGuitar_8, tuningBassGuitar_4, tuningBassGuitar_5, tuningDrum, tuningDrumToms};
