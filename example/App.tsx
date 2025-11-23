import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, Button, ScrollView } from 'react-native';
import { zigAdd, zigMultiply, zigFibonacci } from 'zig-react-native';

export default function App() {
  const [results, setResults] = useState<string[]>([]);

  const runTests = () => {
    const newResults: string[] = [];

    // Test addition
    const sum = zigAdd(5, 10);
    newResults.push(`zigAdd(5, 10) = ${sum}`);

    // Test multiplication
    const product = zigMultiply(7, 8);
    newResults.push(`zigMultiply(7, 8) = ${product}`);

    // Test Fibonacci
    const fib10 = zigFibonacci(10);
    newResults.push(`zigFibonacci(10) = ${fib10}`);

    // Test edge cases
    newResults.push(`zigAdd(-5, 5) = ${zigAdd(-5, 5)}`);
    newResults.push(`zigMultiply(-5, -5) = ${zigMultiply(-5, -5)}`);

    // Test Fibonacci sequence
    newResults.push('\nFibonacci sequence (0-10):');
    for (let i = 0; i <= 10; i++) {
      newResults.push(`  F(${i}) = ${zigFibonacci(i)}`);
    }

    setResults(newResults);
  };

  const runPerformanceTest = () => {
    const iterations = 1000000;
    const newResults: string[] = ['Performance Test Results:', ''];

    // Addition performance
    const addStart = Date.now();
    for (let i = 0; i < iterations; i++) {
      zigAdd(i, i + 1);
    }
    const addTime = Date.now() - addStart;
    newResults.push(`Addition: ${iterations.toLocaleString()} ops in ${addTime}ms`);
    newResults.push(`  ${(iterations / addTime).toFixed(0)} ops/ms`);

    // Multiplication performance
    const mulStart = Date.now();
    for (let i = 0; i < iterations; i++) {
      zigMultiply(i, i + 1);
    }
    const mulTime = Date.now() - mulStart;
    newResults.push(`Multiplication: ${iterations.toLocaleString()} ops in ${mulTime}ms`);
    newResults.push(`  ${(iterations / mulTime).toFixed(0)} ops/ms`);

    // Fibonacci performance (smaller iterations)
    const fibIterations = 10000;
    const fibStart = Date.now();
    for (let i = 0; i < fibIterations; i++) {
      zigFibonacci(20);
    }
    const fibTime = Date.now() - fibStart;
    newResults.push(`Fibonacci(20): ${fibIterations.toLocaleString()} ops in ${fibTime}ms`);
    newResults.push(`  ${(fibIterations / fibTime).toFixed(0)} ops/ms`);

    setResults(newResults);
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Zig React Native Module Demo</Text>
      <Text style={styles.subtitle}>High-performance native functions powered by Zig</Text>

      <View style={styles.buttonContainer}>
        <Button title="Run Tests" onPress={runTests} />
        <View style={styles.buttonSpacer} />
        <Button title="Run Performance Test" onPress={runPerformanceTest} />
        <View style={styles.buttonSpacer} />
        <Button title="Clear" onPress={() => setResults([])} />
      </View>

      <ScrollView style={styles.resultsContainer}>
        {results.map((result, index) => (
          <Text key={index} style={styles.result}>
            {result}
          </Text>
        ))}
      </ScrollView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    paddingTop: 60,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 14,
    color: '#666',
    marginBottom: 20,
    textAlign: 'center',
  },
  buttonContainer: {
    marginBottom: 20,
  },
  buttonSpacer: {
    height: 10,
  },
  resultsContainer: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 8,
    padding: 15,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  result: {
    fontSize: 14,
    fontFamily: 'monospace',
    marginBottom: 4,
  },
});
