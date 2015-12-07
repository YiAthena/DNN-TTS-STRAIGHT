function vu_err=getVU(vu,vu_target)
	tmp=length(vu);
	count=0;
	for i=1:tmp
		if(vu(i)>=0.5)
			vu(i)=1;
			
		else
			vu(i)=0;

		end
	end
	for i=1:tmp
		if (vu(i)~=vu_target(i))
				count=count+1;
		end
	end
	vu_err=count/tmp;
end