function cmp2vu(prj_dir,mgc_dim)
	
data_dir=[prj_dir filesep 'data'];
vu_dir=[data_dir filesep 'vu'];%dynamic par
cmp_dir=[data_dir filesep 'cmp'];

fileList=dir([cmp_dir filesep '*.cmp']);
N=length(fileList);
if N==0
    disp(['No cmp files in ',cmp_dir])
end
delete([vu_dir filesep '*.vu']);

mkdir_if_not_exist(vu_dir);
%if exist(par_path,'dir') == 0, 
%    mkdir(par_path); 
%end
for n=1:50
  
   
    basename=regexp(fileList(n).name,'\.cmp','split');
    basename=char(basename(1));
    str=sprintf([prj_dir ' Analysing file: %s'],basename);
    disp(str)
    
    %try
        
    	par=ReadCmp([cmp_dir filesep fileList(n).name]);

		
		lf0=par(:,79);
    lf01=par(:,80);
    lf02=par(:,81);
      
		VU=get_VU(lf0);
		fid=fopen([vu_dir filesep basename '.vu'],'w');
		fwrite(fid,VU,'float');
		fclose(fid);


        
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



