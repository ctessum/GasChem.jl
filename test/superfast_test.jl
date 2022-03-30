using GasChemMTK
using Test

#=
# ╔═╡ 253dff51-e1c2-498c-8948-8c6176c8bc4d
u₀map = [O3 => 10.0, OH => 10.0, HO2 => 10.0, O2 => 2.1*(10^8), H2O => 450.0, NO => 0.0, NO2 => 10.0, CH4 => 1700.0, CH3O2 => 0.01, CH2O => 0.15, CO => 275.0, CH3OOH => 1.6, CH3O => 0.0, DMS => 50, SO2 => 2.0, ISOP => 0.15, H2O2 => 2.34]



# ╔═╡ 0dd12d9f-25b3-4858-8e41-51b6027184ab
T_ = 250

# ╔═╡ d9187990-4291-4284-b72c-2cb24321e9a1
parammap = [r1 => 1.7*10^(-12)*exp(-940/T_)*2.46*10^10, 
	r2 => 1.0*10^(-14)*exp(-490/T_)*2.46*10^10,
	r3 => 4.8*10^(-11)*exp(250/T_)*2.46*10^10,
	r6 => 3.0*10^(-12)*exp(-1500/T_)*2.46*10^10,
	r7 => 3.5*10^(-12)*exp(250/T_)*2.46*10^10,
	r9 => 2.45*10^(-12)*exp(-1775/T_)*2.46*10^10,
	r11 => 5.50*10^(-12)*exp(125/T_)*2.46*10^10,
	r12 => 4.10*10^(-13)*exp(750/T_)*2.46*10^10,
	r13a => 2.70*10^(-12)*exp(200/T_)*2.46*10^10,
	r13b => 1.10*10^(-12)*exp(200/T_)*2.46*10^10,
	r14 => 2.80*10^(-12)*exp(300/T_)*2.46*10^10,
	r15 => 9.50*10^(-14)*exp(390/T_)/10*2.46*10^10,
	r17 => 1.10*10^(-11)*exp(-240/T_)*2.46*10^10,
	r21a => 2.70*10^(-11)*exp(390/T_)*2.46*10^10,
	r21c => 2.70*10^(-11)*exp(390/T_)/2*2.46*10^10,
	r22 => 5.59*10^(-15)*exp(-1814/T_)*2.46*10^10,
	#rr1
	rr2 => 1.0097*10^-5,
	rr3 => 0.0149,
	rr4 => 0.00014,
	rr5 => 0.00014,
	rr6 => 8.9573*10^-6,
	# rr2 ranges from [0,1.0097251*10^-5] in January, [0,8.817589*10^-6] in July
	# rr3 ranges from [0,0.014947265] in January, [0,0.013702046] in July
	# rr4 & rr5 ranges from [0.00014056443] in January, [0,0001246921] in July
	# rr6 ranges from [0,8.957363*10^-6] in January, [0,7.957547*10^-6] in July
	r4 => 3.0*10^(-13)*exp(460/T_)*2.46*10^10,
	r5 => 1.8*10^(-12)*2.46*10^10,
	r10 => 1.5*10^(-13)*2.46*10^10
]

# ╔═╡ a2dcc8bd-db91-403b-9b0a-cde9dd4334a7
oprob = ODEProblem(rs, u₀map, tspan, parammap)

# ╔═╡ 4c884436-1b3b-4df3-935f-bd33e81098b1
sol = solve(oprob, Tsit5(), saveat=10.)

# ╔═╡ 9eb96078-407b-4ceb-b465-4fbda2821eba
plot(sol,ylim=[0,30], lw=2)

# ╔═╡ e8d1d4a2-4d32-46a9-9b39-b5b137a47b4e
md"""
### Background Information

100mbar approximately means 16km of height. In standard atmophere model, the temperature at sea level at the bottom of the trophophere is 15 °C. At the top of the troposphere, the temperature has fallen to a chilly -57°C.

0-11.1km --> Troposphere where normal lapse rate is ~6.5 °C per km of height; 

11.1-16km --> Tropopause where temperature remains the same.

Infromation from "https://www.windows2universe.org/earth/Atmosphere/troposphere_temperature.html&edu=high"

"""

# ╔═╡ ecb5ca42-4931-4775-9bf1-1a5a781ba1ee
begin
	Surface_temp = 288
	function temp(alt)
	T = 0.0
	if 0<=alt<11.1
		T = Surface_temp-6.5*alt
	elseif 11.1<=alt<=16
		T = Surface_temp-6.5*11.1
	else
		T ="Out of range"
	end
	return round(T,digits=1)
end
	plot(temp, [0:16], [200:300], xlabel="Temperature(K)", ylabel="Altitude(km)")
end

# ╔═╡ c4988bd9-1c8e-4115-a825-1e95320e42cf
md"""
### Model Function
"""

# ╔═╡ 5d8b87fa-8499-474b-9ffd-d3aafcb3a04d
function ozone(T_,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,z)
	u₀map_ = [O3 => a, OH => b, HO2 => c, O2 => d, H2O => e, NO => f, NO2 => g, CH4 => h, CH3O2 => i, CH2O => j, CO => k, CH3OOH => l, CH3O => m, DMS => n, SO2 => o, ISOP => p, H2O2 => q]
	parammap_ = [r1 => 1.7*10^(-12)*exp(-940/T_)*2.46*10^10, 
	r2 => 1.0*10^(-14)*exp(-490/T_)*2.46*10^10,
	r3 => 4.8*10^(-11)*exp(250/T_)*2.46*10^10,
	r6 => 3.0*10^(-12)*exp(-1500/T_)*2.46*10^10,
	r7 => 3.5*10^(-12)*exp(250/T_)*2.46*10^10,
	r9 => 2.45*10^(-12)*exp(-1775/T_)*2.46*10^10,
	r11 => 5.50*10^(-12)*exp(125/T_)*2.46*10^10,
	r12 => 4.10*10^(-13)*exp(750/T_)*2.46*10^10,
	r13a => 2.70*10^(-12)*exp(200/T_)*2.46*10^10,
	r13b => 1.10*10^(-12)*exp(200/T_)*2.46*10^10,
	r14 => 2.80*10^(-12)*exp(300/T_)*2.46*10^10,
	r15 => 9.50*10^(-14)*exp(390/T_)/10*2.46*10^10,
	r17 => 1.10*10^(-11)*exp(-240/T_)*2.46*10^10,
	r21a => 2.70*10^(-11)*exp(390/T_)*2.46*10^10,
	r21c => 2.70*10^(-11)*exp(390/T_)/2*2.46*10^10,
	r22 => 5.59*10^(-15)*exp(-1814/T_)*2.46*10^10,
	rr2 => r,
	rr3 => s,
	rr4 => t,
	rr5 => t,
	rr6 => u,
	r4 => 3.0*10^(-13)*exp(460/T_)*2.46*10^10,
	r5 => 1.8*10^(-12)*2.46*10^10,
	r10 => 1.5*10^(-13)*2.46*10^10
]
	oprob_ = ODEProblem(rs, u₀map_, tspan, parammap_)
	sol_ = solve(oprob_, Tsit5(), saveat=10.)
	plot(sol_,ylim=[0,z], lw=2)
end
#The input of the function is Temperature, concentrations of all chemicals, and reaction rates of photolysis reactions 

# ╔═╡ 282a2582-59a2-45f5-abdc-dfd944006290


# ╔═╡ 17a038fa-b4f5-46fb-8107-5861b8fd2c17
md"""
### Example 1
Relation between ozone concentration and laltitude/temperature
"""

# ╔═╡ 7554ae3d-b04a-4596-923f-63b0f3b7d4cf
ozone(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30),ozone(250,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30),ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30)  
# Higher temperature, less ozone. Reasonable for this model, because higher temperature means higher chemical rates, so more ozone reacts with other chemicals. Besides, higher altitude means lower temperature in stratrosphere, the result of lowering ozone concentration corresponds with the figure shown in the paper. But it could be a coincidence, because we didn't add relation between temperature and photolysis rates and ozone is produced by NO2 photolysis reaction in this model. 

# ╔═╡ 995d8bd8-0f40-4c85-8026-989a86eadcaa
ozone_(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)[1],ozone_(250,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)[1],ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)[1] 
# balanced concentration of ozone at 220K, 250K and 280K

# ╔═╡ 3a87bc48-c2ab-4633-8114-0aaf09123c11
ozone(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30),ozone(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0137, 0.00014, 8.9573*10^-6,30) 
# From the J values provided by CEOS-CHEM, the photolysis reaction rates are higher in January than in July, so if we assume that higher temperature causes that and the same happens in troposphere. Then less ozone produced under higher temperature, which also corresponds with the figure shown in the paper.
# But the range of increased concentration of ozone is not as large as shown in the paper, one possible explanation is that we didn't include O3 + hv --> 2OH in the model because we didn't have that reaction rate.

# ╔═╡ c634cc4b-2834-4053-9ba1-52102acc157c
ozone_(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)[1],ozone_(220,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0137, 0.00014, 8.9573*10^-6)[1]
# balanced concentration of ozone in January and July with different photolysis rates

# ╔═╡ d83e6078-4ea0-4bd5-98a2-79701fde26ad
md"""
### Example 2
Sensitivity Analysis of DMS concentration
"""

# ╔═╡ ed7014d5-8875-4aee-802d-eb03309ccfbf
# DMS: 120-200 nanogram/m3 --> 46-76ppb
ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 46, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30), ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 76, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30) 
# more DMS (30 ppb, 65%), more SO2 (0.9ppb, 45%) and DMS(29ppb,63%)a 

# ╔═╡ 3484f819-1d4f-4fbf-aca0-82d86ea1792b
ozone_(250,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 76, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 46, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)

# ╔═╡ 6f28714c-a7cd-4ebe-bb33-db7be4e32bd4
md"""
### Example 3
Sensitivity Analysis of ISOP concentration
"""

# ╔═╡ 1a1acaa7-49f1-4aa2-b07a-2a44e401e07e
# ISOP: 0.13-0.17ppb up to 0.54 with a lot of people
ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.13, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30), ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.54, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30) 
# More ISOP(0.41,315%), more CH3OOH(0.12 ppb, 80%), CH3O2(0.017 ppb, 70%), CH3OOH(0.47 ppb, 30%), less ozone (-0.16ppb, 1.6%)
# ISOP doesn't produce CH3OOH, while CH3O2 produces CH3OOH

# ╔═╡ 22968cc1-68cf-42f0-89da-ff9ecf9f06de
ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.54, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.13, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)

# ╔═╡ 47de614d-47a7-4ba8-ade0-6fe03f4d8823
md"""
### Example 4
Sensitivity Analysis of NO2 concentration
"""

# ╔═╡ e3bf5bbf-1bfb-4de0-86a5-13e3735728d4
#NO2： 10-100ppb (Normally the NO2 concentration in troposphere is up to 10 ppb, but near the earth, the concentration can be up to 100 ppb.)
ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 100.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,100),ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 50.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,60),ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30)   
#NO2 is critical to the chemical system. More NO2(90ppb, 900%), more ozone(46ppb, 460%), NO（31ppb）， NO2(59ppb, 590%), CH2O(0.11ppb,73%), CH3OOH(-0.67ppb, 42%),H2O2(-2.2ppb, 94%)

# ╔═╡ 7fb99ec2-bdad-4971-9918-9c5a18a99c2a
ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 100.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 0.1, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 0.1, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)

# ╔═╡ 8d957275-6464-49c2-9af3-48b182526363
md"""
### Example 5
Sensitivity Analysis of CO concentration
"""

# ╔═╡ 3a52abeb-3d41-4200-80f5-8567431a7764
#CO:50-500ppb
ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 50.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30),ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 500.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30)  
# The system is not sensitive to CO

# ╔═╡ 238b7903-656a-4b47-b237-7a84a894ddba
ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 50.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 500.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)  

# ╔═╡ 96c84e41-38b3-4b8e-9630-817bf66f61ca
md"""
### Example 6
Sensitivity Analysis of CH4 concentration
"""

# ╔═╡ 3b839b5c-f34c-40b3-9b81-939035424bbb
#CH4: 1600-1900ppb
ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1900.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30),ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1600.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6,30)
#The system is not sensitive to CH4

# ╔═╡ 66295a42-8303-4953-bd73-af849ee8bd0b
ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1900.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-ozone_(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1600.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)   
=#
# ╔═╡ 3e08354e-30ed-428f-b57f-86efab111cbe


# Unit Test 0: Base case
@test begin
	u_0 = [19.496418375934894, 2.575427878206615e-5, 8.72820976446909e-5, 2.100000258619962e8, 6.863386815377445, 
		3.1366131846225587, 1699.9207875744332, 1.288094663908274e-5, 450.30657774123176, 0.20406839106010605, 
		274.59068522862077, 1.767503679261124, 0.040103202241844355, 72.2727774475124, 5.727222552487427, 
		0.04644176611549478, 6.110065745717329]
	test0 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 76, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)

	test0 ≈ u_0
end


# Unit Test 1: DMS sensitivity
@test begin
	n=0
	m=""
	u_dms = [-0.119651
-1.91224e-5
-3.0225e-5
-0.952411
0.0153949
-0.0153949
0.0182646
-7.30047e-6
-0.0788379
-0.0257533
0.0961116
0.00144204
-0.00974384
29.033
0.966983
0.0109903
0.00929881]
	test1 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 76, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-
			GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 46, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)
	compare1 = u_dms-test1
	
	isapprox(test1, u_dms, atol=0.001)
end

# Unit Test 2: ISOP sensitivity
@test begin
	n=0
	m=""
	u_isop = [0.162031
9.9153e-6
6.39096e-5
0.0112869
-0.0231624
0.0231624
0.00147313
2.79975e-5
0.0170129
0.122394
0.0217178
0.468289
0.00558679
0.0440626
-0.0440626
0.104439
-0.196991]
	test2 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.54, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-
		GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.13, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)
	compare2 = u_isop-test2

	isapprox(test2, u_isop, atol=0.001)
end

#  Unit Test 3: NO2 sensitivity
@test begin
	n=0
	m=""
	u_no2 = [46.0443
0.0131283
-0.00821943
274.906
31.0163
58.9837
-1.15577
-0.0016614
4.02589
0.114852
-4.81128
-0.671062
0.178781
-0.0322685
0.0322685
-2.22193e-6
-2.24779]
	test3 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 100.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 0.1, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-
			GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 275.0, 1.6, 0.0, 0.1, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)
	compare3 = u_no2-test3

	isapprox(test3, u_no2, atol=0.001)
end

# Unit Test 4: CO sensitivity
@test begin
	n=0
	m=""
	u_co = [-0.270119
-1.07774e-6
-4.94023e-5
0.0691338
0.0326809
-0.0326809
-0.00479081
-8.59785e-7
0.0154504
0.0015244
-449.16
0.00507079
0.00245152
-0.143228
0.143228
-0.00262908
-0.269762]
	test4 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 50.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-
	GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1700.0, 0.01, 0.15, 500.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)  
	compare4 = u_co-test4

	isapprox(test4, u_co, atol=0.001)
end

# Unit Test 5: CH4 sensitivity
@test begin
	n=0
	m=""
	u_ch4 = [0.00678343
-6.14978e-7
2.55066e-6
-0.00222483
-0.000951862
0.000951862
299.983
1.22716e-6
0.0166712
0.00478461
0.00115292
0.0110191
8.07883e-5
0.00349039
-0.00349039
6.41573e-5
-0.00423393]
	test5 = GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1900.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)-
			GasChemMTK.ozone(280,10.0, 10.0, 10.0, 2.1*(10^8), 450.0, 0.0, 10.0, 1600.0, 0.01, 0.15, 275.0, 1.6, 0.0, 50, 2.0, 0.15, 2.34, 1.0097*10^-5, 0.0149, 0.00014, 8.9573*10^-6)  
	compare5 = u_ch4-test5

	isapprox(test5, u_ch4, atol=0.001)
end
