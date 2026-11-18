require_relative 'nomagacha-data'
require_relative 'ng-seed'

module SeedFinder
  def self.compile_spec(banner, sequence)
    catalog = banner['pools'].flat_map { |p| p['units'] }
    {
      'tiers' => banner['retePsum'],
      'matrix' => banner['pools'].map { |p| p['units'].map { |u| catalog.index(u) } },
      'reroll_tiers' => banner['pools'].each_index.select { |i| banner['pools'][i]['reroll'] },
      'target' => sequence.map { |u| catalog.index(u) }
    }
  end

  def self.resolve_slot(s, tier, matrix, skip = -1)
    row = matrix[tier]
    pos = skip == -1 ? s % row.size : (x = s % (row.size - 1); x >= skip ? x + 1 : x)
    [pos, row[pos]]
  end

  def self.matches?(s, spec)
    recent = -1
    spec['target'].all? do |expected|
      tier = NgSeed.tier_of(s = NgSeed.step(s), spec['tiers'])
      pos, uid = resolve_slot(s = NgSeed.step(s), tier, spec['matrix'])
      _, uid = resolve_slot(s = NgSeed.step(s), tier, spec['matrix'], pos) if uid == recent && spec['reroll_tiers'].include?(tier)
      (recent = uid) == expected
    end
  end

  def self.scan_range(from, to, spec)
    (from...to).select { |s| matches?(s, spec) }
  end
end
