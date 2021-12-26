function data_out=conversion(data_in,a,b)
%Converting image data to its eqivalent binary values.
for k=1:a
    binary_matrix((a+1)-k,:)=rem(data_in,2);
    data_in=floor(data_in./2);
end
%Generating QPSK symbols i.e. 1,2,3 or 4
binary_matrix=reshape(binary_matrix,b,...
    (size(binary_matrix,1)*size(binary_matrix,2))/b);
data_out=zeros(1,size(binary_matrix,2));
for k=1:b
    data_out=data_out+binary_matrix((b+1)-k,:).*b^(k-1);
end