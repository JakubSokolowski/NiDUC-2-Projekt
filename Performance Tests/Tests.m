%1:ALG 1 - bit, 2 - crc32, 3 -sha
%2:Noise 1 - selective, 2 - adjacent, 3- gaussian
%3:Chance
algs = [1,2,3];
algs_names = {'bit','crc32','sha'};
noise = [1,2,3];
noise_names = {'selective','adjacent','gaussian'};
chance = [0.25,0.5,0.75,0.90];


fileid = fopen('arq_wyniki_dane.txt','w');
counter = 0;
for i = 1 : 3
    for j = 1 : 3
        for k = 1 : 4
            result = [0,0];
            total_time = 0;
            for n = 1 : 100
                tic
                result = result + ArqTest(algs(i),noise(j),chance(k));
                total_time = total_time + toc;                
            end; 
            mean_time = total_time / 100;
            %succes_rate = result(1) / 10;
            ratio = result(2) / 100;
           %fprintf(fileid,'%s %s %f\n',algs_names{i},noise_names{j},chance(k));
            fprintf(fileid,'%f %f\n', mean_time,ratio);
            counter = counter + 1;
            disp(counter)
        end;
    end;
end;
fclose(fileid);
disp('Koniec arq')


fileid2 = fopen('non_arq_wyniki_dane.txt','w');
counter = 0;
for i = 1 : 3
    for j = 1 : 3
        for k = 1 : 4
            result = 0;
            total_time = 0;
            for n = 1 : 100
                tic
                result = result + NonArqTest(algs(i),noise(j),chance(k));
                total_time = total_time + toc;                
            end; 
            mean_time = total_time / 100;
            %succes_rate = result(1) / 10;
            ratio = result / 100;
           %fprintf(fileid,'%s %s %f\n',algs_names{i},noise_names{j},chance(k));
            fprintf(fileid2,'%f %f\n', mean_time,ratio);
            counter = counter + 1;
            disp(counter)
        end;
    end;
end;
fclose(fileid2);
disp('Koniec nie arq')








