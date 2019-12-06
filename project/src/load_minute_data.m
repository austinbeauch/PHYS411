close all
clear
t_start = datenum(2010,1,1,0,0,0);
t_end   = datenum(2018,12,31,23,59,59);
[times_minute, james_temps] = getminute("../data/JamesBay_temperature_2019.dat", t_start, t_end);
[~, deep_temps] = getminute("../data/DeepCove_temperature_2019.dat", t_start, t_end);
[~, discovery_temps] = getminute("../data/DiscoveryElementary_temperature_2019.dat", t_start, t_end);
[~, helgesen_temps] = getminute("../data/Helgesen_temperature_2019.dat", t_start, t_end);
[~, john_temps] = getminute("../data/JohnMuir_temperature_2019.dat", t_start, t_end);
[~, keating_temps] = getminute("../data/Keating_temperature_2019.dat", t_start, t_end);
[~, uvic_temps] = getminute("../data/UVicSci_temperature_2019.dat", t_start, t_end);

n_stations = 7;
n_station_array = (1:n_stations);
all_temps = [deep_temps discovery_temps helgesen_temps james_temps keating_temps uvic_temps john_temps].';
labels = ["Deep Cover", "Discovery Elementary", "Helgesen", "James Bay","Keating", "UVic",  "John Muir"'];