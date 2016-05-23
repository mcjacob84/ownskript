function [T,force1,force2]=myHatzePool(data,sigma,rho_C,v)

    for ft = 1:121
        [~,T,forces(ft,:)]=myHatze(data,sigma,0,f_getm(ft),rho_C,v);
    end
    force1=sum(forces)/121;
    
    force2=f_myPool(forces);
    force2=force2/max(force2);
    
end

function [m]=f_getm(ft)
   m=interp1([0,0.3,1],[3.67,9.0735,11.25],(ft-1)/120,'spline'); 
end