import { ExecutionContext, Injectable, UnauthorizedException, ForbiddenException } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Injectable()
export class AdminAuthGuard extends AuthGuard('jwt') {
  
  handleRequest(err, user, info, context: ExecutionContext) {
    
    if (err || !user) {
      throw err || new UnauthorizedException('Acesso negado. Token inválido ou ausente.');
    }

    if (user.id_cargo !== 1) {
      throw new ForbiddenException('Acesso negado');
    }

    return user; 
  }
}