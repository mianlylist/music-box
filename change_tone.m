function [s]=change_tone(y0,b)

u=round(b*2000);
ResampleSign=resample(y0,u,2000); %�ز����ź�
S=800;                       %һ֡�ĳ���
Overlap=400;                 %�ص��������䳤��
Pmax=300;                    %����Ѱ�����������ƶ�λ��
B=S-Overlap;                 %������м��
OriginalLen= length(y0);  %ԭʼ�źŵ����г���
s= zeros(1, OriginalLen);      %Ϊ�����п���ԭʼ�źŵĳ���
ratio = (1:Overlap)/(Overlap+1); %��Ȩ����ϵ��
i = 1:Overlap;
app=1:B;                        %�ź�׷���ƶ�����
%���ز����ź�Ϊģ���½��������Լ���
CalSeries = [ResampleSign, zeros(1,800)];
%ȡԭʼ�źŵ�һ֡������Ҫ�����ģ����ź�
s(1:S) = ResampleSign(1:S);
for newpos = B:B:(OriginalLen-S)
    Originalpos = round(b * newpos);
    y = s(newpos + i);
    rxy = zeros(1, Pmax+1);
    rxx = zeros(1, Pmax+1);
    Pmin=0;
    %����Լ���
    for p =Pmin:Pmax
        x = CalSeries(Originalpos + p + i);
        rxx(p+1) = norm(x);
        rxy(p+1) = (y*x');
    end
    Rxy = (rxx ~= 0).*rxy./(rxx+(rxx==0));
    pm = min(find(Rxy == max(Rxy))-1);
    bestpos = Originalpos+pm;              %��ǰ���ƥ��λ��
    %��Ȩ����
    s(newpos+i)=((1-ratio).*s(newpos+i))+(ratio.*CalSeries(bestpos+i));
    %ȥ���ص������ź�׷�������ź��������
    s(newpos+Overlap+app) = CalSeries(bestpos+Overlap+app);
end