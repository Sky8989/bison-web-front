// https://eslint.org/docs/user-guide/configuring

module.exports = {
  root: true,
  parserOptions: {
    parser: 'babel-eslint'
  },
  env: {
    browser: true,
  },
  extends: [
    // https://github.com/vuejs/eslint-plugin-vue#priority-a-essential-error-prevention
    // consider switching to `plugin:vue/strongly-recommended` or `plugin:vue/recommended` for stricter rules.
    'plugin:vue/essential', 
    // https://github.com/standard/standard/blob/master/docs/RULES-en.md
    'standard'
  ],
  // required to lint *.vue files
  plugins: [
    'vue'
  ],
  // add your custom rules here
  rules: {
    // allow async-await
    'generator-star-spacing': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
    'no-tabs': 0,
    'indent': 0,
    'space-before-function-paren': 0,
    "semi" : 0,
    "import%2Fno-duplicates" : 0,
    "no-unused-vars" : 0,
    "quotes" : 0,
    "key-spacing" : 0,
    "comma-spacing" : 0,
    "comma-dangle" : 0,
    "keyword-spacing" : 0,
    "space-infix-ops" : 0,
    "space-before-blocks" : 0,
    "no-undef" : 0,
    "no-irregular-whitespace" : 0,
    "no-trailing-spaces" : 0,
    "no-multi-spaces" : 0,
    "spaced-comment" : 0,
    "brace-style" : 0,
    "no-sequences" : 0,
    "eol-last" : 0,
    "camelcase" : 0,
    "no-multiple-empty-lines": 0,
    "one-var" : 0,
    "no-cond-assign" : 0,
    "curly" : 0,
    "space-in-parens" : 0,
    "no-unneeded-ternary" : 0,
    "no-unreachable": 0,
    "eqeqeq": 0,
    "padded-blocks": 0,
    "no-useless-return" : 0,
    "arrow-spacing" : 0,
    "no-unused-expressions" : 0,


  }
}
