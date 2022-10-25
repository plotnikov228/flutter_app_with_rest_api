import 'package:flutter_app_with_rest_api/features/post/domain/entityes/post.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/usecase/get_concrete_post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_app_with_rest_api/features/post/domain/repositories/post_repository.dart';

class MockPostRepository extends Mock implements PostRepository {}

void main() {
  MockPostRepository mockPostRepository = MockPostRepository();
  GetConcretePost getConcretePost =  GetConcretePost(mockPostRepository);

  setUp(() {
    mockPostRepository = MockPostRepository();
    getConcretePost = GetConcretePost(mockPostRepository);
  });

  final tPost = Post(userId: 1, id: 1, title: 'title', body: 'body');

  test('should get post from repository', () async {
    when(mockPostRepository.getPost(1, 1, 'title', 'body'))
        .thenAnswer((_) async => tPost);

    final res = await getConcretePost.execute(userID: 1, id: 1, title: 'title', body: 'body', );

    expect(res, tPost);
    verify(mockPostRepository.getPost(1, 1, 'title' , 'body'));
    verifyNoMoreInteractions(mockPostRepository);
  });
}
