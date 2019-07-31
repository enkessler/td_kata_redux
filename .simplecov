SimpleCov.start do
  root __dir__

  add_filter '/test/'

  merge_timeout 300
end
