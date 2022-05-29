import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';

it('renders without crashing', () => {
    const div = document.createElement('div');
    render(<App />, div);
  });
  
it('renders welcome message', () => {
  render(<App />);
  expect(screen.getByText('Learn React')).toBeInTheDocument();
});

