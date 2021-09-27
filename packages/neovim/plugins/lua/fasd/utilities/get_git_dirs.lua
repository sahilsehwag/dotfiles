return F.pipe(
  F.rf('fasd.utilities.get_dirs'),
  F.filter(F.git.is_root)
)
