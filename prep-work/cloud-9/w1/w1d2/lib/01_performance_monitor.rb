def measure(count = 1, &prc)
  start = Time.now
  count.times{prc.call}
  (Time.now - start) / count
end