import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_app/features/joke/presentation/bloc/joke_bloc.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jokes")),
      body: BlocConsumer<JokeBloc, JokeState>(
        listener: (context, state) {
          if (state is JokeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, jokeState) {
          if (jokeState is JokeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (jokeState is JokeFetched) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      jokeState.joke.setup,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      jokeState.joke.punchline,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<JokeBloc>()
                            .add(const JokeRequested.random());
                      },
                      child: const Text("Get Another Joke"),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Initial state
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<JokeBloc>()
                      .add(const JokeRequested.random());
                },
                child: const Text("Get a Random Joke"),
              ),
            );
          }
        },
      ),
    );
  }
}
