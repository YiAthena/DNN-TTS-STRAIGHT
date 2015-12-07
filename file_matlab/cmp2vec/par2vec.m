function par2vec(prj_dir,mgc_dim)
	
data_dir=[prj_dir filesep 'data'];
par_dir=[data_dir filesep 'par_dy'];%dynamic par
cmp_dir=[data_dir filesep 'cmp'];

fileList=dir([cmp_dir filesep '*.cmp']);
N=length(fileList);
if N==0
    disp(['No cmp files in ',cmp_dir])
end
mkdir_if_not_exist(par_dir);
%if exist(par_path,'dir') == 0, 
%    mkdir(par_path); 
%end
for n=1:N
  
   
    basename=regexp(fileList(n).name,'\.cmp','split');
    basename=char(basename(1));
    str=sprintf([prj_dir ' Analysing file: %s'],basename);
    disp(str)
    
    %try
        
    	par=ReadCmp([cmp_dir filesep fileList(n).name]);

		mgc=par(:,1:26);
		mgc1=par(:,27:52);
		mgc2=par(:,53:78);
		lf0=par(:,79);
    lf01=par(:,80);
    lf02=par(:,81);
    bap=par(:,82:107);
    bap1=par(:,108:133);
    bap2=par(:,134:159);

		[lf0_in,lf01_in,lf02_in]=lf0_interp_linear(lf0);
       % lf0_in
%exit;
		%[lf0_in,lf01_in,lf02_in]=lf0_interp_spline(lf0);
		VU=get_VU(lf0);
		%vec=[mgc mgc1 mgc2 lf0_in lf01_in lf02_in VU];
    vec=[mgc lf0_in bap VU];
        max_abs_in=max(abs(vec));

        if(max_abs_in>9999)
            str=sprintf('input data wrong in %s', find(vec,max_abs_in));
            disp(str)
            
        end
     %   fid=fopen([par_dir filesep basename '.target'],'w');

        dlmwrite([par_dir filesep basename '.target'],vec,'\t');
     %   fclose(fid);
        
% 		fid=fopen([par_dir filesep basename '.target'],'wb');
% 		fwrite(fid,vec,'float');
% 		fclose(fid);
    %catch 
       % str=sprintf('.............ERROR NOT ANALYSED!!!');
       % disp(str)
    %end
end

end


function VU=get_VU(lf0)
    VU=zeros(length(lf0),1);
    f0=exp(lf0);
	for i=1:length(lf0)
		if f0(i)>50
			VU(i)=1;
        
        else
			VU(i)=0;
        end
    end
end

function mkdir_if_not_exist(dirpath)
   if dirpath(end) ~= '/', dirpath = [dirpath '/']; end
    if (exist(dirpath, 'dir') == 0), mkdir(dirpath); end
end

function [lf0_in,lf01_in,lf02_in]=lf0_interp_linear(lf0)
    f0=exp(lf0);
    x=find(f0);
    y=f0(x);
%y=lf0(x);
   if(1~=x(1))
    x=[1;x];
   %
         y=[y(1);y];
   end
    if(x(length(x))~=length(f0))
       x=[x;length(f0)];
    
         y=[y;y(length(y))];
    end
    
  %  plot(x);
  %  hold on
  %  plot(y);
    xi=(1:length(lf0))';
  %  plot(x,y);
    f0_in=interp1(x,y,xi,'linear');
lf0_in=log(f0_in);
  %   plot(xi,f0_in);
    
  %   else
  %       lf0_in=log(f0_in);
  %   end
    lf01_in=zeros(length(lf0),1);
    lf02_in=zeros(length(lf0),1);
    for i=2:(length(lf0_in)-1)
        lf01_in(i)=0.5*(lf0_in(i+1)-lf0_in(i-1));
        lf02_in(i)=lf0_in(i+1)-2*lf0_in(i)+lf0_in(i-1);
    end
end

 function [lf0_in,lf01_in,lf02_in]=lf0_interp_spline(lf0)
    f0=exp(lf0);
    x=find(f0);
    y=f0(x);
     x=[1;x;length(f0)];
   % y=[y(1);y;y(length(y))];
            
    y=[0;y;0];
    xi=(1:length(f0))';
    
    f0_in=interp1(x,y,xi,'spline');
  %  plot(x,y);
   % hold on
   % plot(xi,f0_in);
    lf0_in=log(f0_in);
    lf01_in=zeros(length(lf0),1);
    lf02_in=zeros(length(lf0),1);
    for i=2:(length(lf0_in)-1)
        lf01_in(i)=0.5*(lf0_in(i+1)-lf0_in(i-1));
        lf02_in(i)=lf0_in(i+1)-2*lf0_in(i)+lf0_in(i-1);
    end
end  


