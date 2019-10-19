function xc = clip(x, clippingLevel)
    xc=zeros(1,numel(x));
    xc(abs(x)>clippingLevel)=0;
    xc(x>clippingLevel)=x(x>clippingLevel)-0.5;
    xc(x<-clippingLevel)=x(x<-clippingLevel)+0.5;
end