local status_ok, amazonq = pcall(require, "amazonq")
if not status_ok then
  return
end

amazonq.setup({
  ssoStartUrl = 'https://amzn.awsapps.com/start',
  inline_suggest = true,
})
