const webpack = require("webpack");
const { resolve } = require("path");

const demoFolder = resolve("./demo");

module.exports = (env) => {
  const devMode = Boolean(env.WEBPACK_SERVE);

  const loaderConfig = {
    loader: "elm-webpack-loader",
    options: {
      debug: false,
      optimize: !devMode,
      cwd: __dirname,
    },
  };

  const buildOutput = (() => {
    switch (env.target) {
      case "unpkg": {
        return {
          filename: "index.umd.js",
          library: {
            name: "SolanaConnect",
            type: "umd",
            export: ["SolanaConnect"],
          },
        };
      }
      case "module": {
        return {
          filename: "index.js",
          library: {
            type: "module",
          },
        };
      }
      case "demo": {
        return {
          path: demoFolder,
          filename: "bundle.js",
        };
      }
      default: {
        throw Error("no target");
      }
    }
  })();

  const elmLoader = devMode
    ? [{ loader: "elm-reloader" }, loaderConfig]
    : [loaderConfig];

  return {
    mode: devMode ? "development" : "production",
    entry:
      env.target === "demo"
        ? resolve(demoFolder, "index.ts")
        : "./src/index.ts",
    output: buildOutput,
    devServer:
      env.target === "demo" && devMode
        ? {
            port: 8000,
            hot: "only",
            static: {
              directory: demoFolder,
            },
          }
        : undefined,
    experiments:
      env.target === "module"
        ? {
            outputModule: true,
          }
        : undefined,
    stats: devMode ? "errors-warnings" : "normal",
    infrastructureLogging: {
      level: "warn",
    },
    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: elmLoader,
        },
        {
          test: /\.ts$/,
          use: "ts-loader",
          exclude: /node_modules/,
        },
        {
          test: /\.css$/,
          type: "asset/source",
        },
      ],
    },
    resolve: {
      extensions: [".ts", ".js"],
      fallback: {
        url: false,
        zlib: false,
        https: false,
        http: false,
        stream: false,
        crypto: false,
      },
    },
    plugins: [new webpack.NoEmitOnErrorsPlugin()],
  };
};
