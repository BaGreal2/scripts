#!/usr/bin/env node

const https = require('https');

// Get command line args
const [, , query = '', countArg] = process.argv;
const count = parseInt(countArg, 10) || 10;

if (!query) {
  console.error('Usage: node ytsearch.js <query> [count]');
  process.exit(1);
}

const url = `https://www.youtube.com/results?search_query=${encodeURIComponent(query)}`;

https.get(url, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    const jsonStrMatch = data.match(/var ytInitialData = (.+?);<\/script>/s)
      || data.match(/window\["ytInitialData"\] = (.+?);<\/script>/s);
    if (!jsonStrMatch) return console.error('ytInitialData not found');

    const jsonStr = jsonStrMatch[1];
    let ytInitialData;
    try {
      ytInitialData = JSON.parse(jsonStr);
    } catch (e) {
      return console.error('Failed to parse ytInitialData JSON', e);
    }

    const contents = ytInitialData.contents
      .twoColumnSearchResultsRenderer
      .primaryContents
      .sectionListRenderer
      .contents;

    const videos = [];

    for (const section of contents) {
      if (!section.itemSectionRenderer) continue;
      for (const item of section.itemSectionRenderer.contents) {
        if (item.videoRenderer) {
          const video = item.videoRenderer;
          const duration = video.lengthText?.simpleText || '';
          videos.push({
            title: video.title.runs[0].text,
            duration,
            videoId: video.videoId,
          });
        }
      }
    }

    videos.slice(0, count).forEach(v => {
      console.log(`${v.title}\t${v.duration}\t${v.videoId}`);
    });
  });
}).on('error', err => {
  console.error('Request error', err);
});
