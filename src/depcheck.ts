import {getInput, setFailed, info} from '@actions/core'
import depcheck from 'depcheck';


export const run = async (): Promise<void> => {
  try {
    const path = getInput('path', {required: false}) || '.';
    const unused = await runDepcheck(path);
    const dependencies = makeMarkdownList('dependencies', unused.dependencies)
    const devdependencies = makeMarkdownList('devDependencies', unused.devDependencies)
    info(dependencies)
    info(devdependencies)
  } catch (error) {
    setFailed(error.message)
  }
};

const runDepcheck = async(path: string) => {
  const unused = await depcheck(path, {});
  const dependencies = unused.dependencies;
  const devDependencies = unused.devDependencies;
  // const missing = unused.missing;
  return {dependencies, devDependencies}
};

const makeMarkdownList = (title: string, list: string[]) => {
  let text = '';
  text += `- ${title}\n`
  list.forEach((l) => {
    text += '  - ${l}\n'
  })
  return text
}
