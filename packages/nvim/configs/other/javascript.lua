local utils = require("configs.other.utils")

local getJsVariants = F.pipe(
	F.curry(utils.variants)("type", { "spec", "test" }),
	F.curry(utils.variants)("ext", { "js", "ts", "jsx", "tsx" })
)

return {
	{
		pattern = "/src/(.*)/(.*).[jt]s[x]?$",
		target = getJsVariants({
			{ context = "test",    target = "/src/%1/__tests__/%2.{type}.{ext}" },
			{ context = "mock",    target = "/src/%1/__tests__/__mocks__/%2.{ext}" },
			{ context = "fixture", target = "/src/%1/__tests__/__fixtures__/%2.{ext}" },
		}),
	},
	{
		pattern = "/src/(.*)/__tests__/(.*).spec.[jt]s[x]?$",
		target = getJsVariants({
			{ context = "source",  target = "/src/%1/%2.{ext}" },
			{ context = "mock",    target = "/src/%1/__tests__/__mocks__/%2.{ext}" },
			{ context = "fixture", target = "/src/%1/__tests__/__fixtures__/%2.{ext}" },
		}),
	},
	{
		pattern = "/src/(.*)/__tests__/(.*).test.[jt]s[x]?$",
		target = getJsVariants({
			{ context = "source",  target = "/src/%1/%2.{ext}" },
			{ context = "mock",    target = "/src/%1/__tests__/__mocks__/%2.{ext}" },
			{ context = "fixture", target = "/src/%1/__tests__/__fixtures__/%2.{ext}" },
		}),
	},
	{
		pattern = "/src/(.*)/__tests__/__fixtures__/(.*).[jt]s[x]?$",
		target = getJsVariants({
			{ context = "source", target = "/src/%1/%2.{ext}" },
			{ context = "test",   target = "/src/%1/__tests__/%2.{type}.{ext}" },
			{ context = "mock",   target = "/src/%1/__tests__/__mocks__/%2.{ext}" },
		}),
	},
	{
		pattern = "/src/(.*)/__tests__/__mocks__/(.*).[jt]s[x]?$",
		target = getJsVariants({
			{ context = "source",  target = "/src/%1/%2.{ext}" },
			{ context = "test",    target = "/src/%1/__tests__/%2.{type}.{ext}" },
			{ context = "fixture", target = "/src/%1/__tests__/__fixtures__/%2.{ext}" },
		}),
	},
}
