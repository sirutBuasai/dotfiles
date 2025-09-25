local status_ok, amazonq = pcall(require, "amazonq")
if not status_ok then
  return
end

amazonq.setup({
  ssoStartUrl = 'https://view.awsapps.com/start',  -- Authenticate with Amazon Q Free Tier
  inline_suggest = true,
})
