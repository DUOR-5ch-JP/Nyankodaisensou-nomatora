module Translator
  GrpD = {
    'GemiMe' => ['【闇】', '闇', 'Y']
  }

  GrpC = {
    'btC' => ['BC', 'Ｃ', 'C']
  }

  GrpT = {
    'TRD' => ['TR', 'T', 'T']
  }

  GrpB = {
    'Kougeki' => ['攻撃', '攻', 'K'],
    'Charge' => ['ﾁｬｰｼﾞ', '充', 'K'],
    'Kouritu' => ['効率', '効', 'K'],
    'Osaihu' => ['財布', '財', 'K'],
    'Tairyoku' => ['体力', '体', 'K'],
    'Kenkyuu' => ['研究', '研', 'K'],
    'Kaikei' => ['会計', '会', 'K'],
    'Benkyou' => ['勉強', '勉', 'K'],
    'Tousotu' => ['統率', '統', 'K']
  }

  GrpN = {
    'Nuko' => ['ﾈｺ', '猫', '2'],
    'Tank' => ['ﾀﾝｸ', '壁', '2'],
    'Battle' => ['ﾊﾞﾄﾙ', '斧', '2'],
    'Kimo' => ['ｷﾓ', '奇', '2'],
    'Usi' => ['ｳｼ', '牛', '2'],
    'Tori' => ['ﾄﾘ', '鳥', '2'],
    'Fish' => ['ﾌｨｯｼｭ', '魚', '2'],
    'Tokage' => ['ﾄｶｹﾞ', '竜', '2'],
    'Kyojin' => ['巨神', '巨', '2'],
    'Cyojin' => ['超人', '超', '2']
  }

  GrpL = {
    'TiNuko' => ['ﾁﾋﾞﾈｺ', '猫', '1'],
    'TiTank' => ['ﾁﾋﾞﾀﾝ', '壁', '1'],
    'TiBattle' => ['ﾁﾋﾞﾊﾞﾄ', '斧', '1'],
    'TiKimo' => ['ﾁﾋﾞｷﾓ', '奇', '1'],
    'TiUsi' => ['ﾁﾋﾞｳｼ', '牛', '1'],
    'TiTori' => ['ﾁﾋﾞﾄﾘ', '鳥', '1'],
    'TiFish' => ['ﾁﾋﾞﾌｨ', '魚', '1'],
    'TiToka' => ['ﾁﾋﾞﾄｶ', '竜', '1'],
    'TiKyojin' => ['ﾁﾋﾞｷｮ', '巨', '1']
  }

  GrpZ = {
    '5K' => ['0.5万', '.5', 'X'],
    '10K' => ['1万', '①', 'X'],
    '30K' => ['3万', '③', 'X'],
    '50K' => ['5万', '⑤', 'X'],
    '100K' => ['10万', '⑩', 'X'],
    'G100K' => ['10万', '⑩', 'X'],
    '200K' => ['20万', '⑳', 'X'],
    '500K' => ['50万', '㊿', 'X'],
    '1M' => ['100万', '百', 'X'],
    'SPD' => ['SPD', '速', 'U'],
    'CPU' => ['NPU', '動', 'P'],
    'BON' => ['BON', '凡', 'ﾎﾞ'],
    'OKM' => ['OKM', '瓶', 'J'],
    'SNP' => ['SNP', '砂', 'ﾊﾟ'],
    'btA' => ['BA', 'Ａ', 'A'],
    'btB' => ['BB', 'Ｂ', 'B'],
    'Muratane' => ['紫ﾀﾈ', 'ﾑﾗ', 'ﾀ'],
    'Akatane' => ['赤ﾀﾈ', 'ｱｶ', 'ﾀ'],
    'Aotane' => ['青ﾀﾈ', 'ｱｵ', 'ﾀ'],
    'Midotane' => ['緑ﾀﾈ', 'ﾐﾄﾞ', 'ﾀ'],
    'Keytane' => ['黄ﾀﾈ', 'ｷｲ', 'ﾀ'],
    'Muramt' => ['[紫]', '紫', 'ﾑ'],
    'Akamt' => ['[赤]', '赤', 'ｶ'],
    'Aomt' => ['[青]', '青', 'ｵ'],
    'Midomt' => ['[緑]', '緑', 'ﾐ'],
    'Keymt' => ['[黄]', '黄', 'ｷ'],
    'Nijimt' => ['[虹]', '虹', 'ﾆ'],
    'ExMe' => ['【EX】', 'Ｅ', 'E'],
    'ReaMe' => ['【ﾚｱ】', 'ﾚ', 'ﾚ'],
    'GekiMe' => ['【激】', 'ｹﾞ', 'ｹﾞ'],
    'CyoMe' => ['【超】', 'ﾁ', 'ﾁ']
  }

  GrpX = {
    'Normal' => ['ﾉｰﾏﾙ', '並', 'N'],
    'Normal+' => ['ﾉｰﾏﾙ+', '＋', '+'],
    'Matatabi' => ['ﾏﾀﾀﾋﾞ', '叉', 'ﾏ'],
    'Nekome' => ['猫目', '眼', 'ﾒ'],
    'Fukubiki' => ['福引', '福', 'F'],
    'FukubikiG' => ['福引G', 'Ｇ', 'G']
  }

  AllDict = {}.merge(GrpD, GrpC, GrpT, GrpB, GrpN, GrpL, GrpZ, GrpX)

  def self.formatLabel(key, mode)
    k = key.to_s
    entry = AllDict[k]
    return k unless entry

    case mode.to_s
    when 'en'
      k
    when 'short2'
      "#{entry.at(1)}#{entry.at(2)}"
    else
      entry.at(0)
    end
  end

  def self.formatHeader(key, mode)
    k = key.to_s
    entry = GrpX[k]
    return k unless entry

    case mode.to_s
    when 'en'
      k
    when 'short2'
      entry.at(1)
    else
      entry.at(0)
    end
  end

  def self.groupClass(key)
    k = key.to_s
    return 'grp-d' if GrpD.key?(k)
    return 'grp-c' if GrpC.key?(k)
    return 'grp-t' if GrpT.key?(k)
    return 'grp-b' if GrpB.key?(k)
    return 'grp-l' if GrpL.key?(k)
    return 'grp-n' if GrpN.key?(k)
    return 'grp-z' if GrpZ.key?(k)
    'grp-none'
  end
end
