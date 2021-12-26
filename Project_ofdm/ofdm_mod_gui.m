function mod_data=ofdm_mod_gui(symbols,bits_per_symbol,carriers,data_carriers)
if rem(length(symbols),data_carriers)~=0
    integer=ceil(length(symbols)/data_carriers);
    padding=zeros(1,integer*data_carriers);
    padding(1:length(symbols))=symbols;
    symbols=padding;
end
symbol_per_carrier=length(symbols)/data_carriers;
symbols=reshape(symbols,data_carriers,symbol_per_carrier);
global modulated_data
modulated_data=pskmod(symbols,2^bits_per_symbol);
%modulated_data=real(modulated_data);
%figure(2)
%Assignig symbols to their subcarriers
mod_data=zeros(carriers,symbol_per_carrier);
for i=1:symbol_per_carrier
    mod_data([7:32;34:59],i)=modulated_data(1:data_carriers,i);
end
%mod_data=ifftshift(mod_data);
mod_data=ifft(mod_data,carriers);
%matlab takes ifft columnwise
