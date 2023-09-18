const getCacheIdentifier = require('react-dev-utils/getCacheIdentifier');

const shouldUseSourceMap = process.env.GENERATE_SOURCEMAP !== 'false';

module.exports = function override(config, env) {
  // New config, e.g. config.plugins.push...

  const isEnvDevelopment = env === 'development';
  const isEnvProduction = env === 'production';

  config.module.rules = [...config.module.rules,
  {
    test: /\.(?:ts|tsx)$/,
    use: 'ts-loader',
  },
  {
    test: /sunscreen_interop\.wasm$/,
    type: "asset/resource",
    generator: {
      filename: "static/js/[name].wasm"
    }
  },
  {
    test: /\.(?:js|jsx)$/,
    exclude: /node_modules/,
    use: {
      loader: 'babel-loader',
      options: {
          "presets": ["@babel/preset-env", "@babel/preset-react"]
      }
    }
  }
  ];

  config.resolve = {
    extensions: ['.tsx', '.ts', '.js', '.jsx'],
    fallback: {
      "os": require.resolve("os-browserify/browser"),
      "path": require.resolve("path-browserify"),
      "fs": false,
      "crypto": false
    }
  };

  return config
}
