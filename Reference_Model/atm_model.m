clear all;
clc;
%% reading passwords from memory
% Open the file for reading
pass_mem = fopen('password_memory.txt', 'r');

% Read the values from the file
pass_data = fscanf(pass_mem, '%f');

% Close the file
fclose(pass_mem);
%% reading balances from memory
% Open the file for reading
balance_mem = fopen('balance_memory.txt', 'r');

% Read the values from the file
balance_data = fscanf(balance_mem, '%f');

% Close the file
fclose(balance_mem);
%% inputs data from user
%entering the card
card_num =0;
error_count =0;
card_num = input('Please Enter your card : ');

%entering the language 
if card_num ~= 0
    language = input('Please Select your Language: ','s');
else
    card_num = input('Please Enter your card: ');
end

%entering password
%Compare the passwords
for i = 1:3
    user_pass = input('Please Enter your password: ');
    if user_pass == pass_data(card_num)
        disp('Access granted');
        break;
    else
        if i == 3
            disp('Access denied.');
        else
            disp('Access denied. Try again.');
        end
    end
end

%% entering the operation
% Prompt the user for input
if i <3
while(1)
prompt = 'Select an operation:\n1. Withdraw\n2. Deposit\n3. Show balance\n';

% Get input from the user
operation = input(prompt);

% Perform the selected operation
switch operation
    case 1
        for k =1:3
        withdraw=input('Select the withdraw value:\n1. multiple of 100\n2. multiple of 1000\n');
        switch withdraw
            case 1
                button=input('Select the withdraw multi value:\n1. \n2. \n3. \n4. \n5. \n6. \n7. \n8. \n9.\n');
                 switch button
                    case 1
                        entry_value = 100;
                    case 2
                        entry_value = 200;
                    case 3
                        entry_value = 300;
                    case 4
                        entry_value = 400;
                    case 5
                        entry_value = 500;
                    case 6
                        entry_value = 600;
                    case 7
                        entry_value = 700; 
                    case 8
                        entry_value = 800; 
                    case 9
                        entry_value = 900; 
                    otherwise
                        % Invalid input
                        disp('Invalid input');
                 end
             case 2
                button=input('Select the withdraw multi value:\n1. \n2. \n3. \n4. \n5. \n6. \n7. \n8. \n9.\n');
                 switch button
                    case 1
                        entry_value = 1000;
                    case 2
                        entry_value = 2000;
                    case 3
                        entry_value = 3000;
                    case 4
                        entry_value = 4000;
                    case 5
                        entry_value = 5000;
                    case 6
                        entry_value = 6000;
                    case 7
                        entry_value = 7000; 
                    case 8
                        entry_value = 8000; 
                    case 9
                        entry_value = 9000; 
                    otherwise
                        % Invalid input
                        disp('Invalid input');
                 end
        end
        if entry_value <= balance_data(card_num)
            disp('Access granted, Please wait for your money');
            balance_data(card_num) = balance_data(card_num)-entry_value;
            break;
        else
            if k == 3
                disp('Access denied, You do not have enough balance');
            else
                disp('Access denied, You do not have enough balance. Try again');
            end
        end
        end
    case 2
        for k =1:3
        deposit=input('Select the deposit value:\n1. multiple of 100\n2. multiple of 1000\n');
        switch deposit
            case 1
                button=input('Select the deposit multi value:\n1. \n2. \n3. \n4. \n5. \n6. \n7. \n8. \n9.\n');
                 switch button
                    case 1
                        entry_value = 100;
                    case 2
                        entry_value = 200;
                    case 3
                        entry_value = 300;
                    case 4
                        entry_value = 400;
                    case 5
                        entry_value = 500;
                    case 6
                        entry_value = 600;
                    case 7
                        entry_value = 700; 
                    case 8
                        entry_value = 800; 
                    case 9
                        entry_value = 900; 
                    otherwise
                        % Invalid input
                        disp('Invalid input');
                 end
             case 2
                button=input('Select the deposit multi value:\n1. \n2. \n3. \n4. \n5. \n6. \n7. \n8. \n9.\n');
                 switch button
                    case 1
                        entry_value = 1000;
                    case 2
                        entry_value = 2000;
                    case 3
                        entry_value = 3000;
                    case 4
                        entry_value = 4000;
                    case 5
                        entry_value = 5000;
                    case 6
                        entry_value = 6000;
                    case 7
                        entry_value = 7000; 
                    case 8
                        entry_value = 8000; 
                    case 9
                        entry_value = 9000; 
                    otherwise
                        % Invalid input
                        disp('Invalid input');
                 end
        end
        actual_deposit_value= input('Enter the deposit money:\n');
        if entry_value == actual_deposit_value
            disp('Access granted');
            balance_data(card_num) = balance_data(card_num)+entry_value;
            break;
        else
            if k == 3
                disp('Access denied');
            else
                disp('Access denied. Try again');
            end
        end
        end
    case 3
         disp(['Your current balance is : ' , num2str(balance_data(card_num))]);
    otherwise
        % Invalid input
        disp('Invalid input');
end

another_service=input('Do you want another service?:\n1. Yes\n2. No\n');
if another_service == 1
    continue;
else
    break;
end

end
end

    
