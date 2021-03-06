function NMPC_Iter_CodeGen(target,targetLang,args)
% target: 'mex' 'lib' 'dll'
% targetLang: 'C' 'C++'
% args: {x0,lambda,mu,u,x,p,LAMBDA,discretizationMethod,isMEnabled}

target = lower(target);
targetLang = upper(targetLang);

[lambdaDim,segSize,DoP] = size(args{2});
[uDim,segSize,DoP] = size(args{4});
[pDim,segSize,DoP] = size(args{6});
discretizationMethod = args{8};
isMEnabled = args{9};

cfg = coder.config(target);
cfg.FilePartitionMethod = 'SingleFile';
cfg.CustomHeaderCode = '#include "OCP_F_Fu_Fx.h"';

if DoP == 1
    isInParallel = false;
else
    isInParallel = true;
end
cfg.EnableOpenMP = isInParallel;

cfg.TargetLang = targetLang;
stackUsageMax = lambdaDim*segSize*DoP/360*200000;
cfg.StackUsageMax = stackUsageMax;

% generate c++ for OCP_F_Fu_Fx
cfg_OCP_F_Fu_Fx = coder.config('lib');
cfg_OCP_F_Fu_Fx.FilePartitionMethod = 'SingleFile';% single file
cfg_OCP_F_Fu_Fx.BuildConfiguration = 'Faster Runs';
cfg_OCP_F_Fu_Fx.TargetLang = targetLang;
cfg_OCP_F_Fu_Fx.SupportNonFinite = false;
cfg_OCP_F_Fu_Fx.EnableOpenMP = true;
cfg_OCP_F_Fu_Fx.GenerateExampleMain = 'DoNotGenerate';
genArgs_F_Fu_Fx = {zeros(uDim,1),...
                   zeros(lambdaDim,1),...
                   zeros(pDim,1),...
                   discretizationMethod,...
                   isMEnabled};
codegen -config cfg_OCP_F_Fu_Fx...
         OCP_F_Fu_Fx...
         -args genArgs_F_Fu_Fx...
         -d codegen/lib/OCP_F_Fu_Fx
     
if strcmp(targetLang,'C++')
    % cpp source
    cfg.CustomSource = 'OCP_F_Fu_Fx.cpp';
else
    cfg.CustomSource = 'OCP_F_Fu_Fx.c';
end

cfg.CustomInclude = '.\codegen\lib\OCP_F_Fu_Fx';

if ~strcmp(target,'mex')
    cfg.BuildConfiguration = 'Faster Runs'; % no MexCodeConfig 
    cfg.SupportNonFinite = false; % no MexCodeConfig
    cfg.GenerateExampleMain = 'DoNotGenerate'; % no MexCodeConfig
end

codegen -config cfg ...
         NMPC_Iter ...
        -args args