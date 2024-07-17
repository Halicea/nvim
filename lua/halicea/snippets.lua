local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("cs", {
	s({ trig = "dbg", name = "debug" }, {
		t({
			"",
			"#if DEBUG",
			"using System.Diagnostics;",
			"int pid = Process.GetCurrentProcess().Id; int waitMillis = 15000;",
			'Console.WriteLine($"Waiting for Debugger to attach...\\nPID: {pid}");',
			"while (!Debugger.IsAttached && waitMillis > 0) { System.Threading.Thread.Sleep(100); waitMillis -= 100; }",
			'Console.WriteLine(Debugger.IsAttached ? $"Debugger attached... Continuing" : $"Debugger not attached");',
			"#endif",
			"",
		}),
		i(0),
	}),
})
