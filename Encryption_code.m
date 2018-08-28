clear all
clc
l=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
file=fopen('keyword.txt','r');
formatSpec = '%s';
kk=fscanf(file,formatSpec);
kl=kk;
fclose(file);
s11=size(kk);
s1=s11(2);
file1=fopen('message.txt','r');
m=fscanf(file1,formatSpec);
fclose(file1);
o=1;
for i=1:numel(kk)
    key(i)=find(l==kk(i))-1;
end
for i=1:numel(m)
    mes(i)=find(l==m(i));
end
for i=1:numel(mes)
    an(i)=mod(mes(i)+key(o),26);
    if an(i)==0
        an(i)=26;
    end

        o=o+1;
    if (o>numel(key))
        o=1;
    end
end
for i=1:numel(an)
    p(i)=l(an(i));
end
fileID = fopen('encrypted_text.txt','w');
fprintf(fileID,'%s\n',p);
fclose(fileID);
file=fopen('encrypted_text.txt','r');
fi=fscanf(file,"%s");
str=uint16(fi);
fclose(file);
x=imread('lawn.png');
x=uint16(x);
[row,col,chan]=size(x);
c=numel(str);
for i=1:c
    str(i)=str(i)-64;
end
str;
a=1;
for i=1:row
    for j=1:col
        for k=1:chan
            if(a<=c)
                if(x(i,j,k)+str(a)>255)
                    temp=x(i,j,k);
                else
                    temp=x(i,j,k)+str(a);
                    a=a+1;
                end
                z(i,j,k)=uint8(temp);
            else
                z(i,j,k)=uint8(x(i,j,k));
            end
            
        end
    end
end
imwrite(z,'encrypted.png'); 
x=uint8(x);
