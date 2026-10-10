-- Paneru Lua configuration (hot-reloaded on save).
--
-- Replicates niri's default config (resources/default-config.kdl) for macOS,
-- using vim-style motion keys. niri `Mod` (Super on Linux) -> `alt`.
--
-- Key scheme (i3-style vim motions):
--   alt + h/j/k/l           focus west/south/north/east
--   alt + shift + h/j/k/l   move (swap) west/south/north/east   [shift = move]
--   alt + i/u               virtual workspace up/down
--   alt + shift + i/u       send window to workspace up/down
--   alt + <n>               go to virtual workspace <n>
--   alt + shift + <n>       send window to virtual workspace <n>
--
-- (niri's default uses arrow keys + Ctrl-as-move; swapped for vim motions.)
--
-- niri defaults dropped (no macOS/paneru equivalent):
--   input (xkb/libinput), output/monitor config, spawn/spawn-sh, close-window,
--   screenshot, fullscreen-window, set-column-width fine adjust, overview,
--   hotkey-overlay, power-off-monitors, keyboard-shortcuts-inhibit,
--   directional monitor moves (paneru has only `window nextdisplay`).

paneru.setup({
	options = {
		-- niri leaves focus-follows-mouse / warp-mouse-to-focus OFF;
		-- kept paneru's macOS-friendly ON.
		focus_follows_mouse = true,
		mouse_follows_focus = true,

		auto_center = false, -- niri: center-focused-column "never"

		preset_column_widths = { 0.33333, 0.5, 0.66667 }, -- niri 1/3, 1/2, 2/3
		preset_stack_heights = { 0.33333, 0.5, 0.66667 }, -- niri 1/3, 1/2, 2/3

		animation_speed = 24.0, -- niri keeps animations on
	},

	swipe = {
		sensitivity = 0.4,
		continuous = false;
		gesture = {
			fingers_count = 3,
		},
	},

	default_workspaces = 1, -- niri starts with one workspace, grows dynamically

	restore = { enabled = true, startup_grace_ms = 2000 },

	windows = {
		firefox_pip = {
			bundle_id = "org.mozilla.firefox",
			title = "^Picture-in-Picture$",
			floating = true,
		},
		-- niri WezTerm default-column-width workaround (Wayland-only); no direct
		-- paneru equivalent. Uncomment for the closest knob:
		-- wezterm = { bundle_id = "org.wezfurlong.wezterm", title = ".*", width = "complement_focused" },
	},

	bindings = {
		-- Focus / navigate (vim HJKL)
		["window focus west"] = "alt - h",
		["window focus south"] = "alt - j",
		["window focus north"] = "alt - k",
		["window focus east"] = "alt - l",

		["window focus first"] = "alt - home",
		["window focus last"] = "alt - end",

		-- Move / swap (vim capital = move)
		["window swap west"] = "alt + shift - h",
		["window swap south"] = "alt + shift - j",
		["window swap north"] = "alt + shift - k",
		["window swap east"] = "alt + shift - l",
		["window swap first"] = "alt + shift - home",
		["window swap last"] = "alt + shift - end",

		-- Virtual workspaces (niri U/I)
		["window virtual north"] = "alt - i", -- up
		["window virtual south"] = "alt - u", -- down
		["window virtualsend north"] = "alt + shift - i",
		["window virtualsend south"] = "alt + shift - u",

		-- Numbered virtual workspaces
		["window virtualnum 1"] = "alt - 1",
		["window virtualnum 2"] = "alt - 2",
		["window virtualnum 3"] = "alt - 3",
		["window virtualnum 4"] = "alt - 4",
		["window virtualnum 5"] = "alt - 5",
		["window virtualnum 6"] = "alt - 6",
		["window virtualnum 7"] = "alt - 7",
		["window virtualnum 8"] = "alt - 8",
		["window virtualnum 9"] = "alt - 9",
		["window virtualsendnum 1"] = "alt + shift - 1",
		["window virtualsendnum 2"] = "alt + shift - 2",
		["window virtualsendnum 3"] = "alt + shift - 3",
		["window virtualsendnum 4"] = "alt + shift - 4",
		["window virtualsendnum 5"] = "alt + shift - 5",
		["window virtualsendnum 6"] = "alt + shift - 6",
		["window virtualsendnum 7"] = "alt + shift - 7",
		["window virtualsendnum 8"] = "alt + shift - 8",
		["window virtualsendnum 9"] = "alt + shift - 9",

		-- Stacking (vim [ ])
		["window stack"] = "alt - leftbracket",
		["window unstack"] = "alt - rightbracket",

		-- Resize (presets) — niri R
		["window resize"] = "alt - r",
		["window shrink"] = "alt + shift - r",
		["window vertical resize"] = "alt + ctrl + shift - r",

		-- Maximize / center
		["window fullwidth"] = "alt - f", -- niri maximize-column
		["window center"] = "alt - c",

		-- Floating / tabbed display
		["window manage"] = "alt - v", -- niri toggle-window-floating
		["window tabbeddisplay"] = "alt - w", -- niri toggle-column-tabbed-display

		-- Quit (niri Mod+Shift+E)
		["quit"] = "alt + shift - e",
	},
})

-- niri fine width/height adjust -> preset cycling (no fine control in paneru)
paneru.bind("alt - minus", "window shrink")
paneru.bind("alt - equal", "window grow")
paneru.bind("alt + shift - minus", "window vertical shrink")
paneru.bind("alt + shift - equal", "window vertical grow")

-- niri spawn binds (terminal/launcher/locker) have no paneru command; use
-- os.execute in a function bind instead:
-- paneru.bind("alt - t", function() os.execute("open -na alacritty") end)
-- paneru.bind("alt - d", function() os.execute("open -na raycast") end)
