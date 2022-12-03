clear
t=1:0.01:10;
data=sin(t);
plot(t,data,'LineWidth',1.5);
title('y(n)=sin(t)');
xlabel('n');

y = compand(data,80,max(data),'mu/compressor');
n=1;m=10;
o=1;
while ( m< length(t))
    
    D=(y(m)+y(n))/2;
    k=round((m+n)/2);
    N=y(k);
    f=N/D;
    if f >1
    nn=m;
    mn=m+round(1.25*(m-n));
    elseif f==1
        nn=m;
        mn=m+m-n
    elseif f<1
        nn=m;
        mn=m+round(0.5*(m-n));
    end
    n=nn;
    m=mn;
    ind(o)=n;
    o=o+1;
end
figure 
plot(t,y,'LineWidth',1.5)
title('Compressed output');
xlabel('n');

O=zeros(size(y));
for i=1:length(ind)-1
O(ind(i):ind(i+1))=y(ind(i+1));    
end

figure
plot(t,O,'LineWidth',1.5);
title('Quantized output');
xlabel('n');

figure
ny= compand(O,80,max(O),'mu/expander');
plot(t,ny,'LineWidth',1.5)
hold on
plot(t,data,'LineWidth',1.5);
title('Expander output and original signal');
xlabel('n');
legend('Expander','y(n)');

compression_ratio = y/data;
display(compression_ratio)

compression_error =data-y;
average_compression_error = mean(compression_error);
display(average_compression_error)
