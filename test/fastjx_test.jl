using GasChem
using Test

#   Unit Test 0: O3 -> O2 + O(1D)
@testset "o31D" begin
    u_0 = [
        1.8101452673074732e15,
        1.826603407114214e15,
        3.058563926067911e15,
        3.6580860457380195e15,
    ]

    test_0 = [
        GasChem.j_mean_o31D(3600 * 12.0, 30.0, 0, 100.0),
        GasChem.j_mean_o31D(3600 * 12.0, 30.0, 0, 220.0),
        GasChem.j_mean_o31D(3600 * 12.0, 30.0, 0, 300.0),
        GasChem.j_mean_o31D(3600 * 12.0, 30.0, 0, 400.0),

    ]

    @test test_0 ≈ u_0 rtol = 1e-6
end

#   Unit Test 1: H2O2 -> OH + OH
@testset "H2O2" begin
    u_1 = [5.750403366146315e-5, 5.887584133606186e-5, 6.024764962089199e-5]

    test_1 = [
        GasChem.j_mean_H2O2(3600 * 12.f0, 30.0f0, 0, 150.f0),
        GasChem.j_mean_H2O2(3600 * 12.f0, 30.f0, 0, 250.f0),
        GasChem.j_mean_H2O2(3600 * 12.f0, 30.f0, 0, 350.f0),
    ]

    @test test_1 ≈ u_1
end

# Unit Test 2: CH2O -> H + HO2 + CO
@testset "CH2O" begin
    u_2 = [5.200743895500182e-5, 5.20050010722231e-5, 5.200066705839427e-5]

    test_2 = [
        GasChem.j_mean_CH2Oa(3600 * 12., 30., 0, 200.),
        GasChem.j_mean_CH2Oa(3600 * 12., 30., 0, 250.),
        GasChem.j_mean_CH2Oa(3600 * 12., 30., 0, 300.),
    ]

    @test test_2 ≈ u_2
end

# Unit Test 3: CH3OOH -> OH + HO2 + CH2O
@testset "CH3OOH" begin
    u_3 = [0.0, 3.2971571798761734e-5, 0.0]

    test_3 = [
        GasChem.j_mean_CH3OOH(3600 * 6., 30., 0, 200.),
        GasChem.j_mean_CH3OOH(3600 * 12., 30., 0, 200.),
        GasChem.j_mean_CH3OOH(3600 * 18., 30., 0, 200.),
    ]

    @test test_3 ≈ u_3
end

# Unit Test 4: NO2 -> NO + O
@testset "NO2" begin
    u_4 = [0.005079427910534251, 0.005301842146596118, 0.005497566674330561]

    test_4 = [
        GasChem.j_mean_NO2(3600 * 12., 30., 0, 150.),
        GasChem.j_mean_NO2(3600 * 12., 30., 0, 250.),
        GasChem.j_mean_NO2(3600 * 12., 30., 0, 300.),
    ]

    @test test_4 ≈ u_4 rtol = 1e-6
end
