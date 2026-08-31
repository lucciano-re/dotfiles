hl.bind("SUPER + a", hl.dsp.workspace.toggle_special("scratchpadA"), { description = "Toggle scratchpad A" })
hl.bind("SUPER + ALT + a", hl.dsp.window.move({ workspace = "special:scratchpadA", follow = false }),
  { description = "Move window to scratchpad A" })

hl.bind("SUPER + d", hl.dsp.workspace.toggle_special("scratchpadD"), { description = "Toggle scratchpad D" })
hl.bind("SUPER + ALT + d", hl.dsp.window.move({ workspace = "special:scratchpadD", follow = false }),
  { description = "Move window to scratchpad D" })

hl.bind("SUPER + m", hl.dsp.workspace.toggle_special("scratchpadM"), { description = "Toggle scratchpad M" })
hl.unbind("SUPER + ALT + m", hl.dsp.window.move({ workspace = "special:scratchpadM", follow = false }),
  { description = "Move window to scratchpad M" })
hl.bind("SUPER + ALT + m", hl.dsp.window.move({ workspace = "special:scratchpadM", follow = false }),
  { description = "Move window to scratchpad M" })
