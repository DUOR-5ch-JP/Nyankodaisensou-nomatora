require_relative 'nomagacha-data'

module NgSeed
  def self.step(s)
    s ^= (s << 13) & 0xFFFFFFFF
    s ^= (s >> 17)
    s ^= (s << 15) & 0xFFFFFFFF
    s & 0xFFFFFFFF
  end

  def self.tier_of(s, tiers)
    v = s % 10000
    tiers.find_index { |t| v < t } || -1
  end

  def self.pick_from(s, pool, excluded = [])
    return [i = s % pool.size, pool[i]] if excluded.empty?

    i = s % (pool.size - excluded.size)
    [i, pool[i + excluded.count { |x| x <= i }]]
  end

  def self.fast_forward(s, depth, banner)
    recent = ''
    cursor = 0
    shifted = false

    (0..depth).each do |turn|
      cursor = s if turn == depth
      bucket = banner['pools'][tier_of(s = step(s), banner['retePsum'])]
      idx, actor = pick_from(s = step(s), bucket['units'])
      if actor == recent && bucket['reroll']
        shifted = true if turn == depth
        _, recent = pick_from(s = step(s), bucket['units'], [idx])
      else
        recent = actor
      end
    end

    [cursor, shifted]
  end

  def self.forecast(s, depth, banner)
    Array.new(depth) do
      tier = tier_of(t_seed = step(s), banner['retePsum'])
      bucket = banner['pools'][tier]
      idx, actor = pick_from(s = step(t_seed), bucket['units'])
      alt = nil

      if bucket['reroll']
        a_seed, a_actor, seen = s, actor, [idx]
        (bucket['units'].size - 1).times do
          break if a_actor != actor

          n_idx, a_actor = pick_from(a_seed = step(a_seed), bucket['units'], seen)
          seen << n_idx
        end
        alt = { 'id' => a_actor, 'seed' => a_seed }
      end

      {
        'tier' => tier,
        'tier_seed' => t_seed,
        'primary' => { 'id' => actor, 'seed' => s },
        'fallback' => alt,
        'warp' => nil
      }
    end
  end

  def self.project_all(s, depth, active_codes)
    NomagachaData::SixGachas
      .select { |b| active_codes.include?(b['shortname']) }
      .map do |b|
        {
          'title' => b['name'],
          'code' => b['shortname'],
          'alpha_lane' => forecast(s, depth, b),
          'beta_lane' => forecast(step(s), depth, b)
        }
      end
  end
end
