module NomagachaData
  NormalGachaData = {
    'name' => 'Normal',
    'shortname' => 'nm',
    'retePsum' => [10000],
    'pools' => [
      {
        'rate' => 10000,
        'units' => %w[
          Nuko Tank Battle Kimo Usi Tori Fish Tokage Kyojin
          Kougeki Charge Kouritu Osaihu Tairyoku Kenkyuu Kaikei Benkyou Tousotu
        ],
        'reroll' => true
      }
    ]
  }

   NormalPGachaData = {
    'name' => 'Normal+',
    'shortname' => 'n+',
    'retePsum' => [10000],
    'pools' => [
      {
        'rate' => 10000,
        'units' => %w[
          Nuko Tank Battle Kimo Usi Tori Fish Tokage Kyojin Cyojin
          Kougeki Charge Kouritu Osaihu Tairyoku Kenkyuu Kaikei Benkyou Tousotu
        ],
        'reroll' => true
      }
    ]
  }

  MatatabiGachaData = {
    'name' => 'Matatabi',
    'shortname' => 'ma',
    'retePsum' => [400, 2400, 9400, 10000],
    'pools' => [
      {
        'rate' => 400,
        'units' => %w[5K],
        'reroll' => false
      },
      {
        'rate' => 2000,
        'units' => %w[SPD CPU 10K 30K 50K Muratane Akatane Aotane Midotane Keytane],
        'reroll' => true
      },
      {
        'rate' => 7000,
        'units' => %w[BON OKM SNP 100K 200K Muramt Akamt Aomt Midomt Keymt],
        'reroll' => false
      },
      {
        'rate' => 600,
        'units' => %w[TRD 500K Nijimt],
        'reroll' => false
      }
    ]
  }

  NekomeGachaData = {
    'name' => 'Nekome',
    'shortname' => 'ne',
    'retePsum' => [500, 7400, 9400, 9900, 10000],
    'pools' => [
      {
        'rate' => 500,
        'units' => %w[5K],
        'reroll' => false
      },
      {
        'rate' => 6900,
        'units' => %w[10K 30K ExMe ReaMe],
        'reroll' => true
      },
      {
        'rate' => 2000,
        'units' => %w[100K GekiMe],
        'reroll' => false
      },
      {
        'rate' => 500,
        'units' => %w[CyoMe],
        'reroll' => false
      },
      {
        'rate' => 100,
        'units' => %w[GemiMe],
        'reroll' => false
      }
    ]
  }

  FukubikiGachaData = {
    'name' => 'Fukubiki',
    'shortname' => 'fu',
    'retePsum' => [0, 7400, 9500, 10000],
    'pools' => [
      {
        'rate' => 0,
        'units' => [],
        'reroll' => false
      },
      {
        'rate' => 7400,
        'units' => %w[
          TiKyojin TiToka TiFish TiTori TiUsi TiKimo TiBattle TiTank TiNuko
          SPD SPD SPD CPU CPU 10K 10K 10K 30K 30K 30K
        ],
        'reroll' => true
      },
      {
        'rate' => 2100,
        'units' => %w[BON OKM SNP],
        'reroll' => false
      },
      {
        'rate' => 500,
        'units' => %w[TRD],
        'reroll' => false
      }
    ]
  }

  FukubikiGGachaData = {
    'name' => 'FukubikiG',
    'shortname' => 'fg',
    'retePsum' => [0, 5100, 8600, 10000],
    'pools' => [
      {
        'rate' => 0,
        'units' => [],
        'reroll' => false
      },
      {
        'rate' => 5100,
        'units' => %w[btA btA btA G100K G100K G100K],
        'reroll' => true
      },
      {
        'rate' => 3500,
        'units' => %w[btB btB btB 500K],
        'reroll' => false
      },
      {
        'rate' => 1400,
        'units' => %w[btC btC btC 1M],
        'reroll' => false
      }
    ]
  }

  SixGachas = [
    NormalGachaData,
    NormalPGachaData,
    MatatabiGachaData,
    NekomeGachaData,
    FukubikiGachaData,
    FukubikiGGachaData
  ]
end
