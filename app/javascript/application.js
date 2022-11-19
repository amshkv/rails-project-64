// Entry point for the build script in your package.json

import * as Sentry from '@sentry/browser';
import { BrowserTracing } from '@sentry/tracing';

import '@hotwired/turbo-rails';
import './controllers';
import 'bootstrap';

Sentry.init({
  dsn: 'https://1270b892d6254a018b19bef9475f4b6d@o4504181930721280.ingest.sentry.io/4504181933932544',

  integrations: [new BrowserTracing()],

  tracesSampleRate: 1.0,
});
