%从时域上的均衡器
function[gen_x] = time_domain(MUSIC,fs,change)
% [MUSIC, fs] = audioread(filename);

change = power(10,(change/10));

fa = fs/2;
%利用10段巴特沃斯滤波器实现时域滤波均衡器
%0--31频率段
[b,a] = butter(2,[1/fa,30/fa]);
y1=filter(b,a,MUSIC)*change(1);   

[b,a] = butter(2,[32/fa,63/fa]);
y2=filter(b,a,MUSIC)*change(2);
 
[b,a] = butter(2,[61/fa,124/fa]);
y3=filter(b,a,MUSIC)*change(3);
 
[b,a] = butter(2,[126/fa,251/fa]);
y4=filter(b,a,MUSIC)*change(4);
 
[b,a] = butter(2,[249/fa,501/fa]);
y5=filter(b,a,MUSIC)*change(5);
 
[b,a] = butter(2,[499/fa,1002/fa]);
y6=filter(b,a,MUSIC)*change(6);
 
[b,a] = butter(2,[998/fa,2002/fa]);
y7=filter(b,a,MUSIC)*change(7);
 
[b,a] = butter(2,[1998/fa,4003/fa]);
y8=filter(b,a,MUSIC)*change(8);
 
[b,a] = butter(2,[3997/fa,8003/fa]);
y9=filter(b,a,MUSIC)*change(9);
 
[b,a] = butter(2,[7997/fa,16000/fa]);
y10=filter(b,a,MUSIC)*change(10);
%  [b,a] = butter(2,[16000/fa,20000/fa]);
%  y11=filter(b,a,MUSIC)*0;

gen_x = y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;
% subplot(2,1,1);
% plot(MUSIC);
% title('原图像');
% subplot(2,1,2);
% plot(gen_x);
% title('滤波后');
% sound(gen_x, fs);
end