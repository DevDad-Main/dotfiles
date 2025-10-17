import writeData from './util/io.js';

//#region Generate Report Data
/**
 * Generates some dummy data for this demo app.
 * @param {Function} logFn Optional logging function to log the generated data.
 * @returns {string} The generated data.
 */
export function generateReportData(logFn) {
  const data = 'Some dummy data for this demo app';
  if (logFn) {
    logFn(data);
  }

  return data;
}
//#endregion

export async function storeData(data) {
  if (!data) {
    throw new Error('No data received!');
  }
  await writeData(data, 'data.txt');
}
