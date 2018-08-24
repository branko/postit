require 'pry'

def rob_paths(houses, seen_paths={})

  string_houses = houses.to_s

  if seen_paths[string_houses]
    return seen_paths[string_houses], seen_paths
  end

  return -1, seen_paths if houses.nil?
  return 0, seen_paths if houses.empty?


  if houses.length < 3
    seen_paths[string_houses] = houses.max
    return houses.max, seen_paths
  elsif houses.length == 3 && houses[1] > houses[0] + houses[2]
    seen_paths[string_houses] = houses.max
    return houses[1], seen_paths
  end

  fork1, fork2 = [rob_paths(houses[2..-1], seen_paths), rob_paths(houses[3..-1], seen_paths)]

  fork1 ||= {}
  fork2 ||= {}

  seen_paths.merge(fork1[1].merge fork2[1])

  bounty = [houses[0] + fork1[0],
          houses[0] + fork2[0],
          houses[1] + fork2[0]].max

  seen_paths[string_houses] = bounty
  return bounty, seen_paths
end

def rob(houses)
  return rob_paths(houses)[0]
end


houses = [1,4,5,2,6,7,4,8,9,6,7] # = 31
hard_houses = [183,219,57,193,94,233,202,154,65,240,97,234,100,249,186,66,90,238,168,128,177,235,50,81,185,165,217,207,88,80,112,78,135,62,228,247,211]
hard_houses += [1,3,5,34]
# rob(houses)
# p rob([]) == 0
# p rob([1]) == 1
# p rob([9, 1]) == 9
# p rob([1, 9]) == 9
# p rob([1,2,3,4]) == 6
# p rob([1, 3, 1]) == 3
# p rob([1, 2, 1, 1]) == 3
# p rob([1,9,9,1,1,1,9]) == 20
# p rob([1,4,2,7,5,23]) == 34
# p rob([1,4,2,7,5,1]) == 12
# p rob([1, 9, 20, 1, 1, 9, 1]) == 30
time1 = Time.now
p rob(hard_houses)
p Time.now - time1