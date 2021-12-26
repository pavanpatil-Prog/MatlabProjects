%bit images only.
word_size=8;
%bits per symbol
symbol_size=2;
%no of carriers represent ifft size
no_of_carriers=64;
no_of_datacarriers=52;
ofdm_symbol_size=80;
%cyclic prefix length
cp_length=16;
sampling_freq=20*10^6;
faxis=-no_of_carriers/2:no_of_carriers/2-1;
%normalising freq axis
freq_axis=faxis*sampling_freq/no_of_carriers;