function [train_acc, test_acc] = stacked(iter, train_x, train_y, test_x, test_y,s,C,N1,N2,N3)
    [train_u, test_u, train_acc, test_acc] = bls_train(train_x, train_y, test_x, test_y,s,C,N1,N2,N3);
    endtrain = train_u;
    endtest = test_u;
    yy = result(endtrain);
    train_yy = result(train_y);
    TrainingAccuracy = length(find(yy == train_yy))/size(train_yy,1);
    disp(['Training Accuracy is : ', num2str(TrainingAccuracy * 100), ' %' ]);
    y = result(endtest);
    test_yy = result(test_y);
    TestingAccuracy = length(find(y == test_yy))/size(test_yy,1);
    disp(['Testing Accuracy is : ', num2str(TestingAccuracy * 100), ' %' ]);
    disp('-------------------------------------------------------------');
    for i = 1:iter
       stacked_train_y = train_y - train_u;
       stacked_test_y = test_y - test_u;
       if i == 1
            [train_u, test_u, train_acc, test_acc] = bls_train(train_u, stacked_train_y, test_u, stacked_test_y, s, C, 24, 8, 100);
       elseif i == 2
            [train_u, test_u, train_acc, test_acc] = bls_train(train_u, stacked_train_y, test_u, stacked_test_y, s, C, 11, 7, 50);
       elseif i == 3
            [train_u, test_u, train_acc, test_acc] = bls_train(train_u, stacked_train_y, test_u, stacked_test_y, s, C, 5, 6, 70);
       elseif i == 4
            [train_u, test_u, train_acc, test_acc] = bls_train(train_u, stacked_train_y, test_u, stacked_test_y, s, C, 2, 3, 1);
       end
       endtrain = endtrain + train_u;
       endtest = endtest + test_u;
       yy = result(endtrain);
       TrainingAccuracy = length(find(yy == train_yy))/size(train_yy,1);
       disp([num2str(i),'-th Training Accuracy is : ', num2str(TrainingAccuracy * 100), ' %' ]);
       y = result(endtest);
       TestingAccuracy = length(find(y == test_yy))/size(test_yy,1);
       disp([num2str(i),'-th Testing Accuracy is : ', num2str(TestingAccuracy * 100), ' %' ]);
       disp('-------------------------------------------------------------');
    end
    
end

