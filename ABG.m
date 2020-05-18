## Author: Manolis Christodoulou
## Acid/Base disorder analyzer based on Arterial Blood Gas analyzer
## Usage: ABG
## Input: Ph, pCO2, HCO3, Na (mEq/L), Cl (mEq/L)
## The program will give 1 or 2 answers (probably the same or similar,
## plus another one if there is anion gap.

## Copyright (C) 2020  Manolis Christodoulou

# This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.


function ABG()
persistent abg=[
"Compensated Metaboloc Acidosis",
"Uncompensated Metabolic Acidosis",
"Metabolic Acidosis and Respiratory Alcalosis",
"Acute Respiratory Acidosis over Chronic Respiratory Acidosis",
"Uncompensated Acute Respiratory Acidosis",
"Compensated Chronic Respiratory Acidosis",
"Metabolic Acidosis with Anion Gap",
"Metabolic Acidosis with Anion Gap and Acidosis without Anion Gap",
"Metabolic Acidosis with Anion Gap and Metabolic Acidosis",
"Compensated Metabolic Acidosis",
"Metabolic Acidosis and Respiratory Acidosis",
"Metabolic Alcalosis and Respiratory Alcalosis",
"Partially Compensated Respiratory Alcalosis",
"Compensated Chronic Respiratory Alcalosis",
"Uncompensated Acute Respiratory Alcalosis",
"Partially Compensated Respiratory Acidosis",
"Partially Compensated Metabolic Acidosis",
"Partially Compensated Metabolic Alcalosis",
"Uncompensated Metabolic Alcalosis",
"Normal OR Compensated Respiratory Acidosis OR Compensated Metabolic Alcalosis",
"Normal OR Compensated Respiratory Alcalosis OR Compensated Metabolic Acidosis",
"Normal"];

Ph=input("Ph? ");
pCO2=input("pCO2? ");
HCO3=input("HCO3? ");
Na=input("Na? ");
Cl=input("Cl? ");
Alb=input("Albumine? ");
AGAP=0;
printf("ABG Calculator results for...\nPh=%d\npCO2=%d\nHCO3=%d\nNa=%d\nCl=%d\nAlbumin=%d\n",Ph,pCO2,HCO3,Na,Cl,Alb);

if HCO3==24 HCO3=24.01; end
if Ph<7 || Ph>7.7
  disp("Is it alive?");
  return;
end;

AGAP=Na-Cl-HCO3+2.5*(max(0,4.5-Alb));

if Ph<7.35 && HCO3>26 acid1(); end
if Ph<7.35 && HCO3<=26 && HCO3>=22 acid2(); end
if Ph<7.35 && HCO3<22 && pCO2>60 acid3(); end
if Ph<7.35 && HCO3<22 && pCO2<47 acid4(); end
if Ph<7.35 && HCO3<22 && pCO2<=60 && pCO2>=47 acid5(); end

if Ph>=7.35 && Ph<=7.45 && HCO3>26 disp(abg(20,:));
elseif Ph>=7.35 && Ph<=7.45 && HCO3<=22 disp(abg(21,:));
elseif Ph>=7.35 && Ph<=7.45 && HCO3>22 && HCO3<=26 disp(abg(22,:));
end

if Ph>=7.45 && HCO3>26 && pCO2>60 alc3(); end
if Ph>=7.45 && HCO3<22 alc1(); end
if Ph>=7.45 && HCO3<=26 && HCO3>=22 alc2(); end
if Ph>=7.45 && HCO3>26 && pCO2<47 alc4(); end
if Ph>=7.45 && HCO3>26 && pCO2>=47 alc5(); end

function acid1()
disp(abg(16,:));
Arac();
end

function acid2()
disp(abg(5,:));
Arac();
end

function acid3()
disp(abg(11,:));
Arac();
end

function acid4()
disp(abg(17,:));
Amac();
end

function acid5()
disp(abg(2,:));
Amac();
end

function Amac()
x=1.5*HCO3+8-pCO2;
if x<=-0.5 disp(abg(2,:));
elseif x>=0.5 disp(abg(12,:));
else disp(abg(1,:));
end
if AGAP<16 return end
y=HCO3;
if y==24 y=24.01; end
x=(AGAP-12)/(24-y);
if x<1 disp(abg(8,:));
elseif x>2 disp(abg(9,:));
else disp(abg(7,:));
end
end

function Arac()
y=pCO2;
if y==40 y=40.01; end
x=(10^(9-Ph)-10^1.6)/(y-40);
if x>0.8 disp(abg(5,:));
elseif x<0.3 disp(abg(6,:));
else disp(abg(4,:));
end
end


function alc1()
disp(abg(13,:));
Aralc();
end

function alc2()
disp(abg(15,:));
Aralc();
end

function alc3()
disp(abg(18,:));
Amalc();
end

function alc4()
disp(abg(3,:));
Aralc();
end

function alc5()
disp(abg(19,:));
Amalc();
end

function Aralc()
y=pCO2;
if y==40 y=40.01; end
x=(Ph-7.4)/(40-y);
if x<0.0017  disp(abg(14,:));
elseif x>0.008 disp(abg(15,:));
else disp(abg(13,:));
end
end

function Amalc()
x=0.7*HCO3+21-pCO2;
if x<-5 disp(abg(11,:));
elseif x>5 disp(abg(12,:));
else disp(abg(10,:));
end
end

end

