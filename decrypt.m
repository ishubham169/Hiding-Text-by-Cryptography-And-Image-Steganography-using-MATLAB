clear all
clc
l=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
file=fopen('keyword.txt','r');
formatSpec = '%s';
kl=fscanf(file,formatSpec);
fclose(file);
x=imread('lawn.png');
x=uint16(x);
z=imread('encrypted.png');
z=uint16(z);
[row,col,chan]=size(z);
a=1;
for i=1:row
    for j=1:col
        for k=1:chan
            if (x(i,j,k)~=z(i,j,k))
                y(a)=z(i,j,k)-x(i,j,k);
                a=a+1;
            end
        end
    end
end
for i=1:numel(y)
    y(i)=y(i)+64;
end
y=char(y);
b=1;
p=size(kl);
ss=p(2);
for i=1:ss
    po(i)=uint16(kl(i));
end
p=size(y);
ss=p(2);
for i=1:ss
    yy(i)=uint16(y(i));
end
b=1;
yy=int16(yy);
po=int16(po);
for i=1:numel(yy)
    yy(i)=mod(yy(i)-po(b),26);
    b=b+1;
    if b>numel(po)
        b=1;
    end
end
for i=1:numel(yy)
    yy(i)=l(yy(i)+1);
end
yy=char(yy);
fil=fopen('decrypted_text.txt','w');
fprintf(fil,"%s",yy);
fclose(fil);
img=imread('lawn.png');
img1=imread('encrypted.png');
[M, N] = size(img);
error = img - (img1);
MSE = sum(sum(error .* error)) / (M * N);
MSE
[peaksnr,snr] = psnr(z,x);
peaksnr
snr=snr+10
