#include <stdio.h> 
#include <sys/types.h> 
#include <unistd.h> 
int main(){

    printf("A (PID=%d )", getpid());
   pid_t child_id = fork();
   if(child_id == 0){
        printf("|__B (PID=%d, PPID=%d)", getpid(), getppid());
        pid_t childOfB = fork();
        if(childOfB == 0){
            printf("|__E (PID=%d, PPID=%d)", getpid(), getppid());
            pid_t childOfE = fork();
            if(childOfE == 0) printf("|__I (PID=%d, PPID=%d)", getpid(), getppid());
        }
        else{
            wait();
            pid_t child = fork();
            if(child == 0) printf("|__F (PID=%d, PPID=%d)", getpid(), getppid());
        }
    }
    else{
        wait();
        pid_t child2 = fork();
        if(child2 == 0){
            printf("|__C (PID=%d, PPID=%d)", getpid(), getppid());
            pid_t childOfC = fork();
            if(childOfC == 0) printf("|__G (PID=%d, PPID=%d)", getpid(), getppid());    
        }
        else{
            wait();
            pid_t child3 = fork();
            if(child3 == 0){
            printf("|__D (PID=%d, PPID=%d)", getpid(), getppid());
            }
        }
    }
    wait();
    return 0;
}