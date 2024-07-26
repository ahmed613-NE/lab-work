function C = cmap_royal_gramma(N)
% @=============================================================================
% This function is part of the Brainstorm software:
% https://neuroimage.usc.edu/brainstorm
% 
% Copyright (c) University of Southern California & McGill University
% This software is distributed under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPLv3
% license can be found at http://www.gnu.org/copyleft/gpl.html.
% 
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%
% For more information type "brainstorm license" at command prompt.
% =============================================================================@
%
% Authors: Rana El Khoury, 2019

cmap = [
            0.0437439  0.05911447 0.61378545 
           0.05686884 0.06607876 0.60833984 
           0.06808855 0.07216815 0.60337418 
           0.07826286 0.07760475 0.59867971 
           0.08766643 0.08250959 0.59423257 
           0.0964638  0.0869705  0.59002092 
           0.10477897 0.09105481 0.5860266  
           0.11268863 0.09481449 0.58224298 
           0.12027152 0.09829103 0.578648   
           0.12756278 0.10151791 0.57524188 
           0.13460127 0.10452285 0.5720158  
           0.14141805 0.10732893 0.568962   
           0.14804039 0.10995539 0.56607193 
           0.15448634 0.11241897 0.56334156 
           0.16077266 0.11473402 0.5607658  
           0.16692979 0.11691045 0.55832689 
           0.17295451 0.11896096 0.55603282 
           0.17885895 0.1208948  0.55387827 
           0.18466724 0.12271721 0.55184735 
           0.19037021 0.12443884 0.5499504  
           0.19599533 0.12606141 0.54816774 
           0.20153332 0.1275942  0.54650872 
           0.20700119 0.12903927 0.54496132 
           0.21240355 0.13040097 0.54352315 
           0.21773918 0.13168504 0.542196   
           0.2230181  0.13289931 0.54095921 
           0.22821525 0.13409858 0.53973944 
           0.23334151 0.13528059 0.53853372 
           0.23840232 0.13644552 0.5373409  
           0.24340292 0.13759823 0.53614851 
           0.24834735 0.13873137 0.53497339 
           0.25323983 0.13984444 0.53381599 
           0.25808431 0.14093694 0.53267664 
           0.26288485 0.14201377 0.53154196 
           0.26764439 0.14306866 0.53042666 
           0.2723661  0.14410113 0.52933099 
           0.27705264 0.14511089 0.52825525 
           0.28170717 0.14609737 0.52719911 
           0.28633265 0.14706397 0.52615225 
           0.29093085 0.14800628 0.52512583 
           0.29550442 0.14892375 0.52411933 
           0.30005566 0.14981595 0.52313241 
           0.30458626 0.15068267 0.52216512 
           0.30909878 0.15152324 0.52121649 
           0.3135946  0.15233822 0.52028472 
           0.31807624 0.1531277  0.51936633 
           0.32254467 0.15388982 0.51846619 
           0.32700216 0.15462384 0.51758305 
           0.33144966 0.15532968 0.51671687 
           0.33588921 0.1560066  0.51586634 
           0.34032203 0.15665429 0.51503094 
           0.34474939 0.15727234 0.51420993 
           0.34917294 0.15786011 0.51340213 
           0.35359367 0.15841729 0.5126069  
           0.35801275 0.1589434  0.51182333 
           0.3624316  0.1594378  0.51105016 
           0.36685128 0.1599     0.51028644 
           0.37127258 0.16032964 0.50953134 
           0.3756967  0.16072608 0.50878363 
           0.38012467 0.16108874 0.50804209 
           0.38455741 0.16141713 0.50730536 
           0.38899573 0.1617106  0.50657264 
           0.39344048 0.16196852 0.50584289 
           0.3978922  0.16219049 0.50511504 
           0.40235183 0.16237592 0.50438723 
           0.40682011 0.16252408 0.50365846 
           0.41129769 0.16263431 0.50292746 
           0.41578521 0.16270598 0.50219296 
           0.42028324 0.16273842 0.50145368 
           0.42479228 0.16273096 0.50070839 
           0.42931282 0.16268293 0.49995581 
           0.43384536 0.16259357 0.49919464 
           0.43839035 0.16246211 0.49842355 
           0.44294823 0.16228776 0.49764124 
           0.44751936 0.16206971 0.49684643 
           0.45210398 0.16180721 0.49603796 
           0.45670224 0.16149955 0.49521473 
           0.46131466 0.16114562 0.49437525 
           0.4659415  0.16074445 0.49351825 
           0.47058299 0.16029505 0.49264253 
           0.47523926 0.15979648 0.49174696 
           0.47991101 0.15924837 0.49082627 
           0.48459764 0.15864914 0.48988341 
           0.48929959 0.15799726 0.48891703 
           0.49401697 0.15729144 0.48792599 
           0.49874975 0.15653047 0.48690933 
           0.50348733 0.15573443 0.48585078 
           0.50821832 0.15492969 0.48472307 
           0.51294201 0.154118   0.48352458 
           0.51765617 0.15330388 0.48225272 
           0.52235644 0.15249604 0.48090347 
           0.52704723 0.15168688 0.47947957 
           0.53172719 0.15087914 0.47798041 
           0.53639531 0.1500752  0.476405   
           0.5410507  0.14927743 0.47475231 
           0.54569225 0.14848847 0.47302163 
           0.55031895 0.14771097 0.4712123  
           0.55492968 0.14694774 0.46932383 
           0.55952341 0.1462016  0.46735578 
           0.56409908 0.14547543 0.46530783 
           0.56865574 0.14477209 0.46317965 
           0.57319226 0.14409464 0.46097125 
           0.57770758 0.14344618 0.45868275 
           0.58220066 0.1428298  0.45631434 
           0.58667048 0.1422486  0.45386633 
           0.59111492 0.14170815 0.45133845 
           0.59553381 0.14120981 0.44873172 
           0.59992673 0.14075546 0.44604721 
           0.60429269 0.14034818 0.44328577 
           0.60863076 0.13999097 0.44044832 
           0.61294003 0.13968676 0.43753591 
           0.61721965 0.13943841 0.4345497  
           0.62146877 0.13924865 0.43149096 
           0.62568662 0.13912008 0.42836103 
           0.62987245 0.13905516 0.42516134 
           0.63402558 0.13905618 0.42189341 
           0.63814528 0.13912534 0.41855901 
           0.64223095 0.13926458 0.41515986 
           0.64628204 0.13947564 0.41169772 
           0.65029804 0.13976004 0.40817444 
           0.65427848 0.14011909 0.4045919  
           0.65822298 0.14055384 0.40095202 
           0.66213117 0.14106515 0.39725679 
           0.66600278 0.1416536  0.39350818 
           0.66983757 0.14231953 0.38970816 
           0.67363537 0.14306305 0.38585869 
           0.67739606 0.14388402 0.38196172 
           0.6811196  0.14478208 0.37801917 
           0.68480596 0.14575666 0.37403293 
           0.68845518 0.14680698 0.37000498 
           0.69206738 0.14793205 0.365937   
           0.69564269 0.14913068 0.36183077 
           0.69918134 0.15040152 0.35768786 
           0.70268357 0.15174308 0.35350989 
           0.70614967 0.15315372 0.34929828 
           0.70957998 0.15463168 0.34505443 
           0.71297487 0.1561751  0.34077962 
           0.71633474 0.15778203 0.3364751  
           0.71966003 0.15945044 0.33214191 
           0.72295121 0.16117826 0.32778112 
           0.72620879 0.16296336 0.32339341 
           0.7294333  0.16480358 0.31897948 
           0.7326253  0.16669674 0.31453988 
           0.73578533 0.16864069 0.31007517 
           0.738914   0.17063325 0.30558561 
           0.74201189 0.17267228 0.30107154 
           0.74507963 0.17475565 0.29653272 
           0.74811786 0.17688127 0.29196903 
           0.7511272  0.1790471  0.28738014 
           0.75410826 0.18125111 0.28276611 
           0.75705749 0.18350024 0.27812506 
           0.75997846 0.18578633 0.27345661 
           0.76287326 0.18810562 0.26875376 
           0.7657347  0.19046998 0.26402672 
           0.7685592  0.19288574 0.25927437 
           0.77134472 0.19535559 0.25449731 
           0.77408916 0.19788207 0.24969725 
           0.77679042 0.20046761 0.24487539 
           0.77944643 0.20311457 0.24003262 
           0.78205506 0.20582516 0.23516997 
           0.7846142  0.20860146 0.23028846 
           0.78712175 0.21144534 0.22538946 
           0.7895756  0.21435852 0.22047435 
           0.79197366 0.21734251 0.21554443 
           0.79431387 0.22039868 0.21060105 
           0.79659422 0.22352815 0.20564563 
           0.79881268 0.226732   0.20067883 
           0.80096733 0.2300108  0.19570277 
           0.80305632 0.23336497 0.19071916 
           0.80507787 0.23679471 0.18572948 
           0.80703026 0.24029998 0.18073533 
           0.80891184 0.24388064 0.17573767 
           0.81072114 0.24753603 0.17073855 
           0.8124568  0.2512653  0.16573968 
           0.81411756 0.25506742 0.16074251 
           0.81570224 0.25894124 0.15574812 
           0.81720993 0.26288506 0.15075854 
           0.81863983 0.2668971  0.14577524 
           0.8199912  0.27097555 0.14079916 
           0.82126362 0.27511808 0.13583212 
           0.82245673 0.27932235 0.13087528 
           0.82357036 0.28358588 0.12592984 
           0.8246045  0.28790598 0.12099699 
           0.82555929 0.29227991 0.11607771 
           0.82643508 0.29670469 0.1111733  
           0.82723135 0.3011786  0.10628668 
           0.82794592 0.30570183 0.10142579 
           0.82858354 0.31026646 0.09658283 
           0.82914492 0.31486962 0.09175815 
           0.82963101 0.31950831 0.08695248 
           0.83004296 0.32417944 0.082167   
           0.83038201 0.32887994 0.07740299 
           0.83064918 0.33360719 0.0726611  
           0.83084574 0.33835838 0.06794286 
           0.83097303 0.34313083 0.06325014 
           0.8310326  0.34792167 0.05858596 
           0.83102561 0.3527287  0.0539527  
           0.83095341 0.3575496  0.04935423 
           0.83081738 0.36238213 0.04479564 
           0.83061896 0.36722411 0.04028104 
           0.83035951 0.37207355 0.03590628 
           0.83004049 0.37692849 0.03188081 
           0.8296632  0.38178721 0.02819822 
           0.8292289  0.38664813 0.02485243 
           0.82873888 0.39150972 0.02183791 
           0.82819442 0.39637055 0.01914949 
           0.82759604 0.40122988 0.01678659 
           0.82693946 0.40609115 0.01477013 
           0.82623128 0.41094844 0.01307012 
           0.82547297 0.41580035 0.01168343 
           0.82466554 0.42064603 0.01060652 
           0.82380988 0.42548471 0.00983621 
           0.82290703 0.43031557 0.00936985 
           0.82195829 0.43513758 0.0092053  
           0.82096465 0.43995006 0.00934038 
           0.81991973 0.44475791 0.00980653 
           0.81882528 0.44955966 0.01060217 
           0.81768091 0.45435609 0.0116934  
           0.81649666 0.45914205 0.01288776 
           0.81529052 0.46390512 0.01408314 
           0.81406411 0.46864468 0.01528012 
           0.81281799 0.47336098 0.01647873 
           0.81155723 0.47805086 0.01768145 
           0.81027619 0.4827193  0.018885   
           0.80897356 0.48736789 0.02008828 
           0.8076497  0.49199688 0.02129105 
           0.80630437 0.49660695 0.02249266 
           0.80493733 0.50119876 0.02369241 
           0.80354822 0.50577302 0.02488944 
           0.80213698 0.51033021 0.02608296 
           0.80070299 0.51487115 0.02727173 
           0.79924466 0.51939731 0.02845381 
           0.79776312 0.52390826 0.02962878 
           0.79625812 0.52840451 0.03079527 
           0.79472612 0.53288866 0.03194963 
           0.79317178 0.53735797 0.03309335 
           0.79159809 0.54181087 0.03422682 
           0.78999782 0.54625228 0.0353435  
           0.78836899 0.55068363 0.03644    
           0.78670881 0.55510676 0.03751211 
           0.78502988 0.5595142  0.03856633 
           0.78332383 0.56391127 0.03959437 
           0.78157991 0.5683045  0.04058314 
           0.77982218 0.5726798  0.04152774 
           0.77802121 0.57705456 0.04241469 
           0.7762045  0.58141297 0.04326283 
           0.77434708 0.58576944 0.04405234 
           0.7724561  0.59011988 0.04478677 
           0.77054188 0.59445866 0.04547207 
           0.76858774 0.59879502 0.04609369 
           0.76659818 0.60312647 0.04665275 
           0.76457876 0.60745003 0.04715121 
           0.76250734 0.61177737 0.04756895 
           0.76039265 0.61610366 0.04790963 
           0.75820849 0.62044211 0.04814815 
           0.75580652 0.6248669  0.04815365];

P = size(cmap ,1);

if nargin < 1
   N = P;
end

N = min(N, P);
C = interp1(1:P,  cmap  ,linspace(1, P, N) , 'linear');
