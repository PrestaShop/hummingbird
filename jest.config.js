const config = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  moduleNameMapper: {
    '^@js(.*)$': '<rootDir>/src/js$1',
    '^@services(.*)$': '<rootDir>/src/js/services$1',
    '^@constants(.*)$': '<rootDir>/src/js/constants$1',
    '^@helpers(.*)$': '<rootDir>/src/js/helpers$1',
  },
};

module.exports = config;
