import http from 'k6/http';
import { sleep } from 'k6';

// Run load with 10 virtual users for 5 minutes
export const options = {
  vus: 10,
  duration: '5m',
};

// Send a GET to https://test.k6.io then sleep for 1s
// before repeating the function (ie. sending another request)
export default function () {
  http.get('https://test.k6.io');
  sleep(1);
}