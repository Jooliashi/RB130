def organize(arr)
  yield(arr)
end
birds = ['crow', 'finch', 'hawk', 'eagle']
organize(birds) do |_, _, *raptors|
  p raptors
end


