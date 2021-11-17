import {getInput, setFailed, setOutput, info} from '@actions/core'
import {GitHub, context} from '@actions/github'
import depcheck from 'depcheck';


export const run = async (): Promise<void> => {
  try {
    const path = getInput('path', {required: false}) || '.';
    const unused = await runDepcheck(path);
    const github = new GitHub(process.env.GITHUB_TOKEN);
    const {owner, repo} = context.repo;
    setOutput('id', updatedReleaseId.toString());
    setOutput('html_url', updatedHtmlUrl);
    setOutput('upload_url', updatedUploadUrl);
    setOutput('name', updatedReleaseName);
    setOutput('body', updatedBody);
    setOutput('published_at', updatedPublishAt);
    setOutput('tag_name', tag)
  } catch (error) {
    setFailed(error.message)
  }
};

const runDepcheck = async(path: string) => {
  const options = {
    ignoreBinPackage: false, // ignore the packages with bin entry
    skipMissing: false, // skip calculation of missing dependencies
    ignorePatterns: [
      // files matching these patterns will be ignored
      'sandbox',
      'dist',
      'bower_components',
    ],
    ignoreMatches: [
      // ignore dependencies that matches these globs
      'grunt-*',
    ],
    parsers: {
      // the target parsers
      '**/*.js': depcheck.parser.es6,
      '**/*.jsx': depcheck.parser.jsx,
    },
    detectors: [
      // the target detectors
      depcheck.detector.requireCallExpression,
      depcheck.detector.importDeclaration,
    ],
    specials: [
      // the target special parsers
      depcheck.special.eslint,
      depcheck.special.webpack,
    ],
    package: {
      // may specify dependencies instead of parsing package.json
      dependencies: {
        lodash: '^4.17.15',
      },
      devDependencies: {
        eslint: '^6.6.0',
      },
      peerDependencies: {},
      optionalDependencies: {},
    },
  };
  const unused = await depcheck(path, options);
  const dependencies = unused.dependencies;
  const devDependencies = unused.devDependencies;
  // const missing = unused.missing;
  return {dependencies, devDependencies}
};
