n  = 2;
Rp = 10;
Rs = 12;
Wp = 0.5;
[b_high, a_high] = ellip(n, Rp, Rs, Wp, 'high');
[b_low, a_low] = ellip(2,5,40,0.6, 'low');

filtered = filtfilt(b_high, a_high, temps);
filtered = filtfilt(b_low, a_low, filtered);

[Hf_high, wf_high] = freqz(b_high, a_high);
[Hf_low, wf_low] = freqz(b_low, a_low);
plot(wf_high, abs(Hf_high))
plot(wf_low, abs(Hf_low))